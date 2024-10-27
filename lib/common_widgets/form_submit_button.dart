import 'package:flutter/material.dart';
import 'package:timekeeper/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton(
      {required String? text,
      required VoidCallback? onPressed,
      Color? color,
      Color? textColor})
      : super(
          child: Text(
            text!,
            style: TextStyle(color: textColor, fontSize: 20.0),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(color),
            elevation: const WidgetStatePropertyAll(5.0),
          ),
          onPressed: onPressed,
        );
}
