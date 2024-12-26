// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../common/themes/app_colors.dart';
import '../../../../common/themes/app_constants.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = AppColors.primaryColor,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.defaultDuration,
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? AppColors.primaryMaterialColor.shade100,
        borderRadius: const BorderRadius.all(
            Radius.circular(AppConstants.defaultPadding)),
      ),
    );
  }
}
