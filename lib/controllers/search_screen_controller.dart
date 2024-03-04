
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/static_methods.dart';

class SearchScreenController extends GetConnect{

  TextEditingController searchController = TextEditingController();
  RxList<Reastaurant> restList = <Reastaurant>[].obs;
  Random random = Random();
  List<Color> color = [
    kLightRedColor,
    kLightGreenColor,
    kLightYellowColor,
    kLightGreyColor,
    kLightPurpleColor,
    kLightOrangeColor,
    kLightBlueColor,
  ];

  search() async {
    FocusManager.instance.primaryFocus?.unfocus();
    restList.clear();
    String text = searchController.text;
    Response response =
    await get('http://10.0.2.2:8000/api/resturants/search/$text');

    if (response.body['data'] != null) {
      for (var item in response.body['data']) {
        restList.add(Reastaurant.fromJson(item));
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'هیچ پاسخی برای شما از سمت سرور دریافت نشد.');
    }
  }
}