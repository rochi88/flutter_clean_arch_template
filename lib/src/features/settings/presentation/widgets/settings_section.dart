// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../common/widgets/responsive_screen.dart';

class SettingSection extends StatefulWidget {
  final String headerText;
  final double headerFontSize;
  final Color headerTextColor;
  final bool disableDivider;
  final Color backgroundColor;
  final List<Widget> children;

  const SettingSection(
      {required this.headerText,
      required this.headerTextColor,
      required this.headerFontSize,
      required this.children,
      required this.disableDivider,
      required this.backgroundColor,
      super.key});

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: size.getWidthPx(20),
            top: size.getWidthPx(4),
            bottom: size.getWidthPx(4),
          ),
          child: Text(
            widget.headerText,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: widget.headerFontSize,
                fontWeight: FontWeight.w500,
                color: widget.headerTextColor),
          ),
        ),
        Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(10),
            vertical: size.getWidthPx(6),
          ),
          borderOnForeground: true,
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
