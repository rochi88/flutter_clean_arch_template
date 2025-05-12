// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_constants.dart';
import '../providers/auth_controller_provider.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          cursorColor: AppColors.kPrimaryColor,
          maxLength: 11,
          autovalidateMode: AutovalidateMode.onUnfocus,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            hintText: 'Phone',
            prefixIcon: Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Icon(
                Icons.phone,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone';
            } else if (!value.startsWith('01')) {
              return 'Please Enter Valid phone';
            } else if (value.length != 11) {
              return 'Please Enter Valid phone';
            }
            return null;
          },
        ),
        TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          cursorColor: AppColors.kPrimaryColor,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Icon(
                Icons.lock,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final message = await ref
                  .read(authControllerProvider)
                  .signIn(phoneController.text, passwordController.text);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message!)),
                );
              }
            }
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
      ]),
    );
  }
}
