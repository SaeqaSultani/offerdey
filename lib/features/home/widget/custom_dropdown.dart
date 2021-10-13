import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13),),
          border: Border.all(color: Colors.black12,width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on,color: Colors.grey,),
                SizedBox(width: 10,),
                textWidget('Near me', 15, FontWeight.w600, Colors.black54)
              ],
            ),
            const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),],
        ),
      ),
    );
  }
}