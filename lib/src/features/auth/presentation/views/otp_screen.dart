// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../widgets/otp_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //** App Bar **//
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OTP Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Enter OTP to Verify'),
          const SizedBox(
            height: 20,
          ),
          OTPField(
            otpController: controller,
            spaceBetween: 20,
            length: 6,
          )
        ],
      ),

      //** Confirm Button **//
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            if (kDebugMode) {
              print('OTP == ${controller.text}');
            }
          },
          child: const Text('Confirm'),
        ),
      ),
    );
  }
}
