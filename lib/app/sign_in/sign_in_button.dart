import 'package:flutter/material.dart';
import 'package:timekeeper/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    super.key,
    required String? text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text!,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(color),
            elevation: const WidgetStatePropertyAll(5.0),
          ),
          onPressed: onPressed,
        );
}
