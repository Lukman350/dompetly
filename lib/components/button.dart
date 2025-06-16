import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String type;
  final Widget child;
  final GestureTapCallback? onPressed;

  const Button({
    super.key,
    required this.type,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          type == "primary" ? AppColors.mainGreen : AppColors.buttonSecondary,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      child: child,
    );
  }
}
