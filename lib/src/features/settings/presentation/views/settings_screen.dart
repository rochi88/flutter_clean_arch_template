// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../../core/providers/app_state_provider.dart';
import '../../../auth/presentation/providers/auth_controller_provider.dart';
import '../widgets/settings_section.dart';
import '../widgets/switch_row.dart';
import '../widgets/tile_row.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isPrivateAccount = false;
  bool darkMode = false;
  bool bnEnabled = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.read(appStateNotifierProvider).themeMode;
    final languageCode = ref.read(appStateNotifierProvider).languageCode;

    if (languageCode == 'bn') {
      bnEnabled = true;
    } else {
      bnEnabled = false;
    }
    if (themeMode == ThemeMode.dark) {
      darkMode = true;
    } else {
      darkMode = false;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Settings',
              style: TextStyle(
                  fontFamily: 'Exo2', color: Colors.black, fontSize: 20)),
          backgroundColor: Colors.white,
        ),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  accountSection(),
                  pushNotificationSection(),
                  getHelpSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SettingSection accountSection() {
    final userData = ref.watch(getUserProvider);
    return SettingSection(
      headerText: 'Account',
      headerFontSize: 20,
      headerTextColor: Colors.black,
      backgroundColor: Colors.white,
      disableDivider: true,
      children: [
        TileRow(
          label: 'User Name',
          disabled: true,
          rowValue: userData.value?.name,
          disableDivider: false,
          onTap: () {},
        ),
        SwitchRow(
          label: 'Private Account',
          disableDivider: false,
          value: isPrivateAccount,
          onSwitchChange: (switchStatus) {
            setState(() {
              switchStatus ? isPrivateAccount = true : isPrivateAccount = false;
            });
          },
          onTap: () {},
        ),
        SwitchRow(
          label: 'Bengali Language',
          disableDivider: false,
          value: bnEnabled,
          onSwitchChange: (switchStatus) {
            setState(() {
              switchStatus ? bnEnabled = true : bnEnabled = false;
            });
            ref
                .read(appStateNotifierProvider.notifier)
                .setLanguageCode(bnEnabled ? 'bn' : 'en');
          },
          onTap: () {},
        ),
        SwitchRow(
          label: 'Theme Mode',
          disableDivider: false,
          value: darkMode,
          onSwitchChange: (switchStatus) {
            setState(() {
              switchStatus ? darkMode = true : darkMode = false;
            });
            ref
                .read(appStateNotifierProvider.notifier)
                .setThemeMode(switchStatus ? ThemeMode.dark : ThemeMode.light);
          },
          onTap: () {},
        ),
      ],
    );
  }

  SettingSection pushNotificationSection() {
    return SettingSection(
      headerText: 'Push Notifications',
      headerFontSize: 20,
      headerTextColor: Colors.black,
      backgroundColor: Colors.white,
      disableDivider: true,
      children: [
        TileRow(
          label: 'Contact Us',
          disableDivider: false,
          onTap: () {},
        ),
        TileRow(
          label: 'Contact Us',
          disableDivider: false,
          onTap: () {},
        ),
      ],
    );
  }

  SettingSection getHelpSection() {
    return SettingSection(
      headerText: 'Get Help',
      headerFontSize: 15,
      headerTextColor: Colors.black,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        TileRow(
          label: 'Contact Us',
          disableDivider: false,
          onTap: () {},
        ),
        TileRow(
          label: 'Terms and Condition',
          disableDivider: false,
          onTap: () {},
        ),
        TileRow(
          label: 'Feedback',
          disableDivider: false,
          onTap: () {},
        ),
        TileRow(
          label: 'Log out',
          disableDivider: false,
          onTap: () {
            ref.read(authControllerProvider).signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged out'),
              ),
            );
          },
        ),
      ],
    );
  }
}
