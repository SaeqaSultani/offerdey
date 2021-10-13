import 'package:dawahazir_rider/features/home/data/model/price_range_class.dart';
import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/material.dart';

class PriceRangeCard extends StatelessWidget {
  const PriceRangeCard({
    Key? key, required this.priceRange, required this.index,
  }) : super(key: key);

  final PriceRange priceRange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey,width: 1)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(priceRange.price, 18, FontWeight.w400, Colors.black),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey,width: 1)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(priceRange.price, 18, FontWeight.w400, Colors.black),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Icon(Icons.check,color: Colors.white,size: 15,),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}