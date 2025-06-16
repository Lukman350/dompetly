import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final RxnString? errorText;
  final RxBool? obscureText;
  final bool isPassword;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;

  const CustomFormField({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.obscureText,
    this.isPassword = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText == null ? false : obscureText!.value,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              errorText: errorText?.value,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText!.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
