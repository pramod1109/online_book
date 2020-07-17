import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_book/views/home_grid.dart';
import 'package:carousel_pro/carousel_pro.dart';

// ignore: must_be_immutable
class HomeFirst extends StatelessWidget {
  String uid;

  HomeFirst(this.uid);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      children: [
        SizedBox(
            height: 150.0,
            width: 500.0,
            child: Carousel(
              images: [
                ExactAssetImage("assets/images/1.jpeg"),
                ExactAssetImage("assets/images/2.jpeg"),
                ExactAssetImage("assets/images/1.jpeg")
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Color(0xff61A4F1),
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.redAccent[100].withOpacity(0),
              moveIndicatorFromBottom: 180.0,
              noRadiusForIndicator: true,
            )),
        GridList(uid)
      ],
    )));
  }
}
