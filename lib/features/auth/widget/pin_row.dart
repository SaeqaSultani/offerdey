import 'package:flutter/material.dart';

import 'pin_input_field.dart';

class PinRow extends StatefulWidget {
  const PinRow({
    required this.onChanged,
    required this.successCallback,
    required this.setPin,
    this.activeColor = Colors.black,
  });

  final Function() onChanged;
  final Function(String) successCallback;
  final Function(String) setPin;
  final Color activeColor;

  @override
  _PinRowState createState() => _PinRowState();
}

class _PinRowState extends State<PinRow> {
  late TextEditingController pin1;
  late TextEditingController pin2;
  late TextEditingController pin3;
  late TextEditingController pin4;
  late TextEditingController pin5;
  late TextEditingController pin6;
  late FocusNode pin1Node;
  late FocusNode pin2Node;
  late FocusNode pin3Node;
  late FocusNode pin4Node;
  late FocusNode pin5Node;
  late FocusNode pin6Node;

  @override
  void initState() {
    pin1 = TextEditingController();
    pin1Node = FocusNode();
    pin2 = TextEditingController();
    pin2Node = FocusNode();
    pin3 = TextEditingController();
    pin3Node = FocusNode();
    pin4 = TextEditingController();
    pin4Node = FocusNode();
    pin5 = TextEditingController();
    pin5Node = FocusNode();
    pin6 = TextEditingController();
    pin6Node = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    pin1.dispose();
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
    pin5.dispose();
    pin6.dispose();
    pin1Node.dispose();
    pin2Node.dispose();
    pin3Node.dispose();
    pin4Node.dispose();
    pin5Node.dispose();
    pin6Node.dispose();
    super.dispose();
  }

  void Function()? returnPin() {
    FocusScope.of(context).unfocus();

    String text1 = pin1.text;
    String text2 = pin2.text;
    String text3 = pin3.text;
    String text4 = pin4.text;
    String text5 = pin5.text;
    String text6 = pin6.text;

    widget.successCallback('$text1$text2$text3$text4$text5$text6');
  }

  void Function()? updateTac() {
    String text1 = pin1.text;
    String text2 = pin2.text;
    String text3 = pin3.text;
    String text4 = pin4.text;
    String text5 = pin5.text;
    String text6 = pin6.text;
    widget.setPin('$text1$text2$text3$text4$text5$text6');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PinInputField(
          activeColor: widget.activeColor,
          controller: pin1,
          currentFocusNode: pin1Node,
          nextFocusNode: pin2Node,
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
        PinInputField(
          activeColor: widget.activeColor,
          controller: pin2,
          previousFocusNode: pin1Node,
          currentFocusNode: pin2Node,
          nextFocusNode: pin3Node,
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
        PinInputField(
          controller: pin3,
          previousFocusNode: pin2Node,
          currentFocusNode: pin3Node,
          nextFocusNode: pin4Node,
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
        PinInputField(
          activeColor: widget.activeColor,
          controller: pin4,
          previousFocusNode: pin3Node,
          currentFocusNode: pin4Node,
          nextFocusNode: pin5Node,
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
        PinInputField(
          activeColor: widget.activeColor,
          controller: pin5,
          previousFocusNode: pin4Node,
          currentFocusNode: pin5Node,
          nextFocusNode: pin6Node,
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
        PinInputField(
          activeColor: widget.activeColor,
          controller: pin6,
          previousFocusNode: pin5Node,
          currentFocusNode: pin6Node,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => returnPin(),
          onChanged: () {
            updateTac();
            widget.onChanged();
          },
        ),
      ],
    );
  }
}
