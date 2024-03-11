import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.obscureText = false,
      this.keyboardType,
      this.trailingIcon,
      this.validator});
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final Widget? trailingIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 19),
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xff0D0140)),
          ),
        ),
        const SizedBox(
          height: 11,
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              focusColor: Colors.red,
              filled: true,
              hintStyle: TextStyle(
                  color: const Color(0xff0D0140).withOpacity(0.6),
                  fontSize: 12),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              suffixIcon: trailingIcon),
          obscureText: obscureText,
          style: const TextStyle(color: Color(0xff0D0140), fontSize: 12),
          controller: controller,
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: validator,
        ),
      ],
    );
  }
}
