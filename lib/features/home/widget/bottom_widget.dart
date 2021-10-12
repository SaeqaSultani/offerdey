import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/material.dart';


class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(5),
              height:50,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow:  const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                      spreadRadius: 2, //spread radius
                      blurRadius: 7,
                    )
                  ]
              ),
              child: Center(child: textWidget('Rant', 16, FontWeight.w400, Colors.grey))),
          Container(
              margin: EdgeInsets.all(5),
              height:50,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF0195FF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD2F2FF),
                      offset: Offset(2, 2),
                      spreadRadius: 2, //spread radius
                      blurRadius: 7,
                    )
                  ]
              ),
              child: Center(child: textWidget('Sale', 16, FontWeight.w600, Colors.white))),
        ],
      ),
    );
  }
}
