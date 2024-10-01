import 'package:flutter/material.dart';
import 'package:timekeeper/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required String? assetName,
    required String? text,
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName!),
              Text(
                text!,
                style: TextStyle(color: textColor),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(color),
            elevation: const WidgetStatePropertyAll(5.0),
          ),
          onPressed: onPressed,
        );
}
