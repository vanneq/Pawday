import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/app/theme/colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.trailing,
    required this.controller,
  });

  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? trailing;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: navColor),
        prefixIcon: Icon(icon, color: navColor, size: 24.r),
        suffixIcon: trailing,
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        filled: true,
        fillColor: navBgColor.withValues(alpha: 0.76),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: primaryColor, width: 1.6),
        ),
      ),
    );
  }
}
