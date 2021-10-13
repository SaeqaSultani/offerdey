import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddingList extends StatefulWidget {
  const AddingList({Key? key}) : super(key: key);

  @override
  _AddingListState createState() => _AddingListState();
}

class _AddingListState extends State<AddingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F4F4),
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget('Sell An Item', 18, FontWeight.w600, Colors.teal),
              SizedBox(height: 15,),
              SizedBox(height: 0.5,width: 500,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: textWidget('Add up to 6 good looking photos.', 11, FontWeight.w600, Colors.teal),),
            Container(
              margin: const EdgeInsets.all(25),
              height: 110,
              width: 110,
              child: DottedBorder(
                  padding: EdgeInsets.all(6),
                  color: Colors.teal,
                  dashPattern: const [10, 10],
                  strokeWidth: 2,
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: const [
                        Center(child: Icon(Icons.add,size: 40,color: Colors.teal,))
                      ],),
                  )),),
            Container(
              height: 60,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 25,right: 25),
                child:  const TextField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      hintText: 'What are you selling ?',
                    )
                 ),
              ),
              ),
            const SizedBox(height: 25,),
            Container(
              color: Colors.white,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(left: 25,right: 25),
                child:  const TextField(
                    maxLength: 1000,
                    style: TextStyle(color: Colors.black),
                    //scrollPadding: EdgeInsets.only(left: 25),
                    cursorColor: Colors.grey,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      //contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      hintText: 'Describe your item',
                    )
                ),
              ),
            ),
            Container(margin:const EdgeInsets.all(25),child: textWidget('Product Info', 18, FontWeight.w600, Colors.grey)),
            Container(
              height: 60,
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.only(left: 25,right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget('Choose your category', 14, FontWeight.w400, Colors.grey),
                    Icon(Icons.arrow_forward_ios,color: Colors.teal,size: 18,)
                  ],
                )
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              height: 60,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(left: 25,right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget('Condition of item', 14, FontWeight.w400, Colors.grey),
                      Icon(Icons.arrow_drop_down,color: Colors.teal)
                    ],
                  )
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              height: 60,
              color: Colors.white,
              child: Container(
                  margin: const EdgeInsets.only(left: 25,right: 25),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                            color:Colors.teal,
                            child: Center(
                              child: textWidget('> 5 Kg', 16, FontWeight.w400, Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                            color:Colors.white,
                            child: Center(
                              child: textWidget('> 10 Kg', 16, FontWeight.w400, Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                            color:Colors.white,
                            child: Center(
                              child: textWidget('> 15 Kg', 16, FontWeight.w400, Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                            color:Colors.white,
                            child: Center(
                              child: textWidget('< 20 Kg', 16, FontWeight.w400, Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            const SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
