// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../../common/widgets/responsive_screen.dart';
import '../../../../common/widgets/visibility.dart';

class SwitchRow extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final bool disableDivider;
  final Color? backgroundColor;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onSwitchChange;
  final bool disabled;
  final bool value;
  final bool isVisible;

  const SwitchRow(
      {super.key,
      required this.label,
      this.labelColor,
      required this.disableDivider,
      this.backgroundColor,
      required this.onTap,
      required this.onSwitchChange,
      this.disabled = false,
      required this.value,
      this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return VisibleWidget(
      visibility: isVisible ? VisibilityFlag.visible : VisibilityFlag.gone,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: disabled ? () {} : onTap,
            child: Container(
              key: key,
              color: backgroundColor,
              padding: EdgeInsets.only(
                right: size.getWidthPx(12),
                left: size.getWidthPx(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: size.getWidthPx(12),
                      left: size.getWidthPx(12),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                          fontFamily: 'Exo2',
                          fontSize: 14.0,
                          color: disabled
                              ? Colors.black54
                              : labelColor ?? Colors.black),
                    ),
                  ),
                  CupertinoSwitch(value: value, onChanged: onSwitchChange),
                  // Platform.isAndroid
                  //     ? Switch(value: value, onChanged: onSwitchChange)
                  //     : CupertinoSwitch(value: value, onChanged: onSwitchChange)
                ],
              ),
            ),
          ),
          VisibleWidget(
            visibility: disableDivider != true
                ? VisibilityFlag.visible
                : VisibilityFlag.gone, // If last row remove divider
            child: Divider(
              height: 1.0,
              indent: size.getWidthPx(2),
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
