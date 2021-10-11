import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.hintText,
    required this.controller,
    this.icon,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.keyboardType,
  });

  final String? hintText;
  final TextEditingController controller;
  final String? icon;

  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          obscureText: isHide,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
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
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.icon != null ? 40.w : 16.w,
              vertical: 12.h,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 4.w,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isHide = !isHide;
              });
            },
            child: SvgPicture.asset(
              isHide
                  ? 'asset/images/auth/svg/show.svg'
                  : 'asset/images/auth/svg/hide.svg',
              width: 32.w,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        if (widget.icon != null)
          Positioned(
            top: 0,
            bottom: 0,
            left: 4.w,
            child: SvgPicture.asset(
              widget.icon!,
              width: 32.w,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
      ],
    );
  }
}
