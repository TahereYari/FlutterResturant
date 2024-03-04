import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/controllers/basket_screen_controller.dart';
import 'package:online_ostore/controllers/bast_restaurant_controller.dart';
import 'package:online_ostore/controllers/category_controller.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/controllers/productController.dart';
import 'package:online_ostore/controllers/resturant_controller.dart';
import 'package:online_ostore/controllers/search_screen_controller.dart';
import 'package:online_ostore/controllers/splash_screen_controller.dart';
import 'package:online_ostore/controllers/user_controller.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {

   Get.lazyPut<SplashScreenController>(() => SplashScreenController());
   Get.lazyPut<UserController>(() => UserController());
   Get.lazyPut<UserController>(() => UserController(),tag: 'login',fenix: true);
   Get.lazyPut<UserController>(() => UserController(),tag: 'signup',fenix: true);
   Get.lazyPut<RestaurantController>(() => RestaurantController(),fenix: true);
   Get.lazyPut<CategoryController>(() => CategoryController(),fenix: true);
   Get.lazyPut<ProductController>(() => ProductController(),fenix: true);
   Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
   Get.lazyPut<SearchScreenController>(() => SearchScreenController(),fenix: true);
   Get.lazyPut<BeatRestaurantController>(() => BeatRestaurantController(),fenix: true);
   Get.lazyPut<BasketScreenController>(() => BasketScreenController(),fenix: true);
  }

}