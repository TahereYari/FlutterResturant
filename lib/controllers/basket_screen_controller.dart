import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/models/basket.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/models/wallet.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketScreenController extends GetConnect {
  Rx<Reastaurant> restaurant = Reastaurant().obs;
  late SharedPreferences pref;
  RxList<Product> products = <Product>[].obs;
  RxList<Basket> baskets = <Basket>[].obs;
  TextEditingController checkOutController = TextEditingController();
  RxInt basketSum = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  loadPref() async {
    pref = await SharedPreferences.getInstance();
  }

  getUserBasket() async {
    await loadPref();
    baskets.clear();
    products.clear();
    String token = pref.getString('token') ?? '-1';
    int id = pref.getInt('restaurantId') ?? -1;

    Response response = await get(
      'http://10.0.2.2:8000/api/front/resturant/$id',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    if (response.statusCode! < 300) {
      restaurant.value = Reastaurant.fromJson(response.body['resturant']);

      for (var item in response.body['products']) {
        products.add(Product.fromJson(item));
      }

      for (var item in response.body['basket']) {
        baskets.add(Basket.fromJson(item));
      }
      getSum(baskets, products);
    }
  }

  getSum(List<Basket> baskets, List<Product> products) async {
    int productSum = 0;
    int sum = 0;
    for (var item in baskets) {
      for (var product in products) {
        if (item.productId == product.id) {
          productSum = item.count! * product.price!;
          sum += productSum;
        }
      }
    }
    basketSum.value = sum;
  }

  checkout() async {
    String price = checkOutController.text;
    int userId = pref.getInt('user_id') ?? -1;
    String token = pref.getString('token') ?? '-1';
    Response response = await get(
      'http://10.0.2.2:8000/api/front/wallet/$price',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    if (response.statusCode! < 300) {
      Wallet wallet = Wallet.fromJson(response.body);
      if (wallet.price! >= basketSum.value) {
        await get(
          'http://10.0.2.2:8000/checkout/$userId',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ).then((value) {
          if (value.body == 'done') {
            Get.back();
            Get
                .find<HomeController>()
                .currentIndex
                .value = 0;
            pref.remove('restaurantId');
            StaticMethodes.succesDialog('خرید شما با موفقیت انجام شد.');

          }
          else {
            StaticMethodes.unSuccesDialog(
                'مبلغ پول شما از مبلغ خریدتان کمتر می باشد.');
          }
        });
      }
    }
  }


}
