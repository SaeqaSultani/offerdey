import 'dart:ui';
import 'package:dawahazir_rider/features/home/screen/filter_screen.dart';
import 'package:dawahazir_rider/features/home/widget/bottom_widget.dart';
import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:dawahazir_rider/features/home/widget/item_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/bloc/auth/auth_bloc.dart';
import '../../../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NoAuth) {
          Navigator.of(context).pushReplacementNamed(RouteGenerator.login);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Image.asset('asset/icons/menu.png'),
          title: textWidget('Alibay',20,FontWeight.w400,Colors.black),
          actions: [
            InkWell(
              onTap: (){
              showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              clipBehavior: Clip.antiAlias,
              //elevates modal bottom screen
              elevation: 10,
              // gives rounded corner to modal bottom screen
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
                ),
               ),
              builder: (BuildContext context) {
              return Container(
                height: 400,
                child: const FilterScreen(),
                 );
                },
              );
              },
                child: Image.asset('asset/icons/filter.png')),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15,right: 15,top: 115),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        textWidget('The type you inserted', 20, FontWeight.w400, Colors.black),
                        const SizedBox(height: 15,),
                         BottomWidget(0),
                        const SizedBox(height: 15,),
                        Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return const ItemsCard();
                            },
                            itemCount: 7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                left: 12,
                right: 12,
                child: Container(
                  height: 175,
                  decoration:  BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('asset/images/1.jpeg'),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF8F9BB3),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
