// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
const actionColor = Color(0xFF5F5FA7);

final divider = Divider(color: white.withOpacity(0.3), height: 1);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('home'.tr()),
        ),
        drawer: SidebarX(
          controller: _controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(color: Colors.white),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            itemDecoration: BoxDecoration(
              border: Border.all(color: canvasColor),
            ),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: actionColor.withOpacity(0.37),
              ),
              gradient: const LinearGradient(
                colors: [accentCanvasColor, canvasColor],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.28),
                  blurRadius: 30,
                )
              ],
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 20,
            ),
          ),
          extendedTheme: const SidebarXTheme(
            width: 200,
            decoration: BoxDecoration(
              color: canvasColor,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
          footerDivider: divider,
          headerBuilder: (context, extended) {
            return SafeArea(
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/avatar.png'),
                ),
              ),
            );
          },
          items: [
            SidebarXItem(
              icon: Icons.home,
              label: 'home'.tr(),
              onTap: () {
                context.go('/');
                debugPrint('Hello');
              },
            ),
            SidebarXItem(
              icon: Icons.settings,
              label: 'settings'.tr(),
              onTap: () {
                debugPrint('Hello');
              },
            ),
            SidebarXItem(
              icon: Icons.person,
              label: 'profile'.tr(),
              onTap: () {
                debugPrint('Hello');
              },
            ),
            SidebarXItem(
              icon: Icons.logout,
              label: 'logout'.tr(),
              onTap: () {
                debugPrint('Hello');
              },
            ),
          ],
        ),
        body: const Placeholder(),
      ),
    );
  }
}
