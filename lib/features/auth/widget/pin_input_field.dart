import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinInputField extends StatefulWidget {
  const PinInputField({
    required this.controller,
    this.currentFocusNode,
    this.nextFocusNode,
    this.previousFocusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    required this.onChanged,
    this.hasError = false,
    this.activeColor = Colors.black,
  });

  final TextEditingController controller;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final FocusNode? currentFocusNode;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;
  final Function() onChanged;
  final bool hasError;
  final Color activeColor;

  @override
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  late bool filled;
  @override
  void initState() {
    filled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.surface,
        ),
        controller: widget.controller,
        focusNode: widget.currentFocusNode,
        textInputAction: widget.textInputAction,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 1,
        textAlign: TextAlign.center,
        showCursor: false,
        obscureText: true,
        obscuringCharacter: '⚫',
        onChanged: (String text) {
          widget.onChanged();
          if (text != '') {
            setState(() {
              filled = true;
            });
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          } else if (widget.controller.text == '') {
            setState(() {
              filled = false;
            });
            FocusScope.of(context).requestFocus(widget.previousFocusNode);
          }
        },
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.background,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            hintText: '',
            hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
            counterText: '',
            contentPadding: EdgeInsets.zero),
      ),
    );
  }
}
