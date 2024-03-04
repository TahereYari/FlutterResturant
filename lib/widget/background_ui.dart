import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/widget/shape_maker.dart';

class BackgroundUI extends StatelessWidget {
  const BackgroundUI(
      {Key? key,
      this.children = const [],
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.floatingActionButton,
      this.floatingActionButtonLocation})
      : super(key: key);

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ShapeMaker(
            height: 160,
            width: 150,
            color: kLightRedColor,
            top: 0,
            right: 0,
          ),
          const ShapeMaker(
            height: 140,
            width: 140,
            color: kLightGreyColor,
            top: 20,
            right: 20,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 160,
            width: 160,
            color: kLightBlueColor,
            top: 0,
            right: 100,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 160,
            width: 160,
            color: kLightYellowColor,
            top: 0,
            left: 0,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 120,
            width: 120,
            color: kLightOrangeColor,
            top: 0,
            left: 80,
            shape: BoxShape.circle,
          ),
          ShapeMaker(
            height: 140,
            width: 140,
            color: kLightPurpleColor,
            top: 100,
            right: Get.width / 2 - 70,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 100,
            width: 100,
            color: kLightRedColor,
            bottom: 0,
            left: 0,
          ),
          const ShapeMaker(
            height: 140,
            width: 140,
            color: kLightGreenColor,
            bottom: 10,
            right: 0,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 160,
            width: 160,
            color: kLightBlueColor,
            bottom: 0,
            right: 100,
            shape: BoxShape.circle,
          ),
          const ShapeMaker(
            height: 100,
            width: 100,
            color: kLightOrangeColor,
            bottom: 0,
            right: 0,
            shape: BoxShape.circle,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              color: Colors.white.withOpacity(0.1),
              child:  SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: crossAxisAlignment,
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
