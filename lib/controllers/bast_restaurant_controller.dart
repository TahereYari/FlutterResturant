import 'dart:io';
import 'package:get/get.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeatRestaurantController extends GetConnect {
  RxList<Reastaurant> bestList = <Reastaurant>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Reastaurant> newList = <Reastaurant>[].obs;
  RxList<Product> products = <Product>[].obs;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getFrontApis();
    getToken();
  }
   Future<String> getToken() async {
    SharedPreferences  pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
    return token;
  }


  getFrontApis() async {
    Response response = await get(
      'http://10.0.2.2:8000/api/front',
      headers: {HttpHeaders.authorizationHeader: 'Bearer token'},
    );

    if (response.statusCode! < 300) {
      for (var item in response.body['bestResturant']) {
        bestList.add(Reastaurant.fromJson(item));
      }

      for (var item in response.body['categories']) {
        categories.add(Category.fromJson(item));
      }

      for (var item in response.body['resturants']) {
        newList.add(Reastaurant.fromJson(item));
      }
    }
  }

  getProductOfCategory(int id) async {
    products.clear();
    Response response = await get(
      'http://10.0.2.2:8000/api/front/category/$id',
      headers: {HttpHeaders.authorizationHeader: 'Bearer token'},
    );
    if (response.statusCode! < 300) {
      for (var item in response.body) {
        products.add(Product.fromJson(item));
      }
    }
  }
}
