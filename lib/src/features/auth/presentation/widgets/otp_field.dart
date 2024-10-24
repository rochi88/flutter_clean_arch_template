// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPField extends StatefulWidget {
  final int length;
  final TextEditingController otpController;
  final double spaceBetween;
  const OTPField(
      {super.key,
      this.length = 4,
      this.spaceBetween = 10,
      required this.otpController});

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  final List<TextEditingController> _textControllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    addRequired();
  }

  void addRequired() {
    for (int i = 0; i < widget.length; i++) {
      _textControllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
// To Listen Keyboard Events
    return KeyboardListener(
      onKeyEvent: (event) {
        // Checking the whether the user click any key
        if (event is KeyDownEvent) {
          // Checking if  the user click on backspace
          if (event.logicalKey.keyLabel == 'Backspace') {
            // Method to change the focus to previous box
            changeFocusToPreviousNodeWhenTapBackspace();
          }
        }
      },
      focusNode: FocusNode(),
      child: SizedBox(
        height: 50,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(
                      right:
                          index == widget.length - 1 ? 0 : widget.spaceBetween),
                  child: TextField(
                    maxLength: 1,
                    focusNode: _focusNodes[index],
                    controller: _textControllers[index],
                    textAlign: TextAlign.center,
                    decoration:
                        const InputDecoration(counter: SizedBox.shrink()),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      // for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        widget.otpController.text = getCombinedString();
                        if (index < widget.length - 1) {
                          // changing the focus to next box using index
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        } else {
                          // removing the keyboard focus
                          _focusNodes[index].unfocus();
                        }
                      }
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  void changeFocusToPreviousNodeWhenTapBackspace() async {
    // Wait because this is running before [changeFocusToPreviousNodeWhenValueIsRemoved]
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      final index = _focusNodes.indexWhere((element) => element.hasFocus);

      /// need to work on this when the user click on backspace the focus should not move until the value is empty
      if (index > 0 && _focusNodes[index].hasFocus) {
        if (_focusNodes[index].hasFocus &&
            _textControllers[index].text.isNotEmpty) {
          if (!mounted) return;
          FocusScope.of(context).requestFocus(_focusNodes[index]);
        } else {
          if (!mounted) return;
          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        }
      }
      widget.otpController.text = getCombinedString();
    } catch (e) {
      debugPrint('Cannot focus on the previous field');
    }
  }

// getCombinedString this method is used to get the otp as single string
  String getCombinedString() {
    String combinedString = '';
    for (TextEditingController controller in _textControllers) {
      combinedString += controller.text; // You can add any delimiter here
    }
    return combinedString.trim(); // Trim to remove extra spaces
  }
}
