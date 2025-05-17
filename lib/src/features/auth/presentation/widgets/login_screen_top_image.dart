// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import '../../../../core/themes/app_constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppConstants.defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset('assets/icons/login.svg'),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: AppConstants.defaultPadding * 2),
      ],
    );
  }
}
