// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../providers/auth_controller_provider.dart';

class SigninFormWidget extends ConsumerWidget {
  const SigninFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60 - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              autovalidateMode: AutovalidateMode.onUnfocus,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                  label: Text('Phone'),
                  prefixIcon: Icon(Icons.numbers_outlined)),
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
            const SizedBox(height: 60 - 20),
            TextFormField(
              controller: passwordController,
              autofillHints: const [AutofillHints.password],
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text('Password'), prefixIcon: Icon(Icons.fingerprint)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 60 - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(authControllerProvider)
                      .signIn(phoneController.text, passwordController.text);
                },
                child: Text('Sign in'.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
