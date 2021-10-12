import 'package:dawahazir_rider/features/home/widget/text_widget.dart';
import 'package:flutter/material.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Stack(
                children:[
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15) ),
                      image: DecorationImage(
                          image: AssetImage('asset/images/1.jpeg'),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                        child: const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 25,),
                      )
                  ),
                  Positioned(
                    top: 15,
                    child: Center(
                      child: CustomPaint(
                        painter: Chevron(),
                        child: Container(
                            width: 70.0,
                            height: 35.0,
                            child:  Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  textWidget('-22%', 10, FontWeight.w600, Colors.white),
                                  textWidget('First mount', 8, FontWeight.w600, Colors.white)
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget('House', 13, FontWeight.w400, Colors.grey),
                  SizedBox(width: 50,),
                  Row(
                    children: [
                      textWidget('2 Beds', 13, FontWeight.w400, Colors.grey),
                      SizedBox(width: 10,),
                      textWidget('2 Beds', 13, FontWeight.w400, Colors.grey),
                      SizedBox(width: 10,),
                      textWidget('92sqft', 13, FontWeight.w400, Colors.grey),

                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget('AntonyHouse', 15, FontWeight.w400, Colors.black),
                  textWidget('\$344.50', 15, FontWeight.w400, Colors.blue),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on,color: Colors.blue,size: 20,),
                  SizedBox(
                      child: textWidget('7744 S. Mill Pond Street Wethersfield,CT', 14, FontWeight.w400, Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chevron extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient =  LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF0195FF), Color(0xFF0195FF)],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 1.2, size.height - size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}