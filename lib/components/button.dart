import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class Button extends StatelessWidget {
  final ButtonType type;
  final Widget? child;
  final bool isLoading;
  final GestureTapCallback? onPressed;

  const Button({
    super.key,
    required this.type,
    required this.child,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          type == ButtonType.primary
              ? AppColors.mainGreen
              : AppColors.buttonSecondary,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : child,
    );
  }
}
