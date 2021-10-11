import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    this.hintText,
    required this.controller,
    this.icon,
    this.isPassword = false,
    this.isNumber = false,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.keyboardType,
  });

  final String? hintText;
  final TextEditingController controller;
  final String? icon;
  final bool isPassword;
  final bool isNumber;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          obscureText: isPassword,
          textInputAction: textInputAction,
          controller: controller,
          onSubmitted: onSubmitted,
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
          keyboardType: isNumber ? TextInputType.number : keyboardType,
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5.sp,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5.sp,
              ),
            ),
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: icon != null ? 40.w : 16.w,
              vertical: 12.h,
            ),
          ),
        ),
        if (icon != null)
          Positioned(
            top: 0,
            bottom: 0,
            left: 4.w,
            child: SvgPicture.asset(
              icon!,
              width: 32.w,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
      ],
    );
  }
}
