import 'package:dawahazir_rider/features/home/data/model/categories_class.dart';
import 'package:dawahazir_rider/features/home/data/model/price_range_class.dart';
import 'package:dawahazir_rider/features/home/widget/bottom_widget.dart';
import 'package:dawahazir_rider/features/home/widget/categories_card.dart';
import 'package:dawahazir_rider/features/home/widget/custom_dropdown.dart';
import 'package:dawahazir_rider/features/home/widget/price_range_card.dart';
import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);
  

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {


List<Categories> items = [
  Categories('Apartment', 'asset/images/1.jpeg'),
  Categories('Land', 'asset/images/1.jpeg'),
  Categories('Village', 'asset/images/1.jpeg'),
  Categories('Town', 'asset/images/1.jpeg'),
];

List<PriceRange> pricesItems = [
  PriceRange('> 500'),
  PriceRange('> 1.000'),
  PriceRange('< 7000'),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget('Reset', 16, FontWeight.w400, Colors.grey),
              textWidget('Filter', 16, FontWeight.w400, Colors.black),
              textWidget('Apply', 16, FontWeight.w400, Colors.blue),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 18,right: 18,top: 20,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   [
               BottomWidget(1),
              SizedBox(height: 15,),
              CustomDropDown(),
              SizedBox(height: 20,),
              Row(
                children: [
                  Card(
                    shadowColor: Color(0xFFD2F2FF),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.home,color: Colors.blue,size: 20,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  textWidget('Categories', 18, FontWeight.w600, Colors.black54)
                ],
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(items.length, (index){
                      return CategoriesCard(categories: items[index], index: index);
                    }
                    )
                  ],
                )
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Card(
                      shadowColor: Color(0xFFD2F2FF),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:  Center(child: textWidget('\$', 15, FontWeight.w400, Colors.blue))
                    ),
                  ),
                  SizedBox(width: 10,),
                  textWidget('Price Range', 18, FontWeight.w600, Colors.black54)
                ],
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(pricesItems.length, (index){
                        return PriceRangeCard(priceRange: pricesItems[index], index: index);
                      }
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}





