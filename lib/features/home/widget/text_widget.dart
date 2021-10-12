import 'package:flutter/material.dart';

Widget textWidget(String text,double size,FontWeight fontWeight,Color color){
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight
    ),
  );
}