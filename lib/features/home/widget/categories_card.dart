import 'package:dawahazir_rider/features/home/data/model/categories_class.dart';
import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key, required this.categories, required this.index,
  }) : super(key: key);

  final Categories categories;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(categories.image),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.blue,width: 2)
                ),
              ),
              SizedBox(height: 4,),
              textWidget(categories.text, 12, FontWeight.w600, Colors.blue)
            ],
          ),
        ),
        SizedBox(width: 20,),
        Container(
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(categories.image),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey,width: 2)
                ),
              ),
              SizedBox(height: 4,),
              textWidget(categories.text, 12, FontWeight.w600, Colors.grey)

            ],
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
