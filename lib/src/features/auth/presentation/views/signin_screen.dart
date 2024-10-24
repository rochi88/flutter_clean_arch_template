// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import '../widgets/form_header_widget.dart';
import '../widgets/signin_form_widget.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormHeaderWidget(
                  image: 'assets/images/outline-unlock.png',
                  title: 'Welcome Back',
                  subTitle: 'Enter your credentials to access your account',
                  imageHeight: 0.15,
                ),
                SigninFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
