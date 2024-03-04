import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  late SharedPreferences pref;
 late String token ;
  RxList<Product> productList = <Product>[].obs;

  RxList<Category> categoryList = <Category>[].obs;
  RxInt dropDownCategoryValue = 3.obs;
  RxList<DropdownMenuItem<int>> dropdownCategoryList =
      <DropdownMenuItem<int>>[].obs;

  RxList<Reastaurant> RestaurantList = <Reastaurant>[].obs;
  RxInt dropDownRestaurantValue = 2.obs;
  RxList<DropdownMenuItem<int>> dropdownRestaurantList =
      <DropdownMenuItem<int>>[].obs;

  onInit() {
    super.onInit();
    getCategoryList();
    getProductList();
    getRestaurantList();
    getToken();
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
  }

  getProductList() async {
    await getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما دسترسیی به این عملیات را ندارید.');
      return;
    } else {
      Dio myDio = Dio();
      myDio
          .get(
        'http://10.0.2.2:8000/api/admin/products',
        options: Options(
          method: 'GET',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then((response) {
        if (response.statusCode! < 300) {
          for (var item in response.data['data']) {
            productList.add(
              Product.fromJson(item),
            );
          }
        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'شما دسترسیی به این عملیات را ندارید.');
          return;
        }
      });
    }
  }

  getCategoryList() async {
    await getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما دسترسیی به این عملیات را ندارید.');
      return;
    } else {
      Dio myDio = Dio();
      myDio
          .get(
        'http://10.0.2.2:8000/api/admin/categories',
        options: Options(
          method: 'GET',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then((response) {
        if (response.statusCode! < 300) {
          // for (var item in response.data['data']) {
          //   categoryList.add(Category.fromJson(item),);
          // }
          // for (int i = 0; i < categoryList.length; i++) {
          //   var dropdownItem = DropdownMenuItem(
          //     value: i + 1,
          //     child: Text(categoryList[i].name!),
          //   );
          //   dropdownCategoryList.add(dropdownItem);
          // }

          for (var item in response.data['data']) {
            categoryList.add(
              Category.fromJson(item),
            );
          }
          for (var item in categoryList) {
            var dropdownItem = DropdownMenuItem(
              value: item.id,
              child: Text(item.name!),
            );
            dropdownCategoryList.add(dropdownItem);
          }
        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'شما دسترسیی به این عملیات را ندارید.');
          return;
        }
      });
    }
  }

  getRestaurantList() async {
    await getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما دسترسیی به این عملیات را ندارید.');
      return;
    } else {
      Dio myDio = Dio();
      myDio
          .get(
        'http://10.0.2.2:8000/api/admin/resturants',
        options: Options(
          method: 'GET',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then((response) {
        if (response.statusCode! < 300) {
          for (var item in response.data['data']) {
            RestaurantList.add(
              Reastaurant.fromJson(item),
            );
          }
          for (var item in RestaurantList) {
            var dropdownItem = DropdownMenuItem(
              value: item.id,
              child: Text(item.title!),
            );
            dropdownRestaurantList.add(dropdownItem);
          }

          // for (var item in response.data['data']) {
          //   RestaurantList.add(Reastaurant.fromJson(item),);
          // }
          // for (int i = 0; i < RestaurantList.length; i++) {
          //   var dropdownItem = DropdownMenuItem(
          //     value: i + 1,
          //     child: Text(RestaurantList[i].title!),
          //   );
          //   dropdownRestaurantList.add(dropdownItem);
          // }
        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'شما دسترسیی به این عملیات را ندارید.');
          return;
        }
      });
    }
  }

  createProduct() async {
    getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String price = priceController.text;
      int categoryId = dropDownCategoryValue.value;
      int restaurantId = dropDownRestaurantValue.value;

      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['price'] = price;
      newMap['category_id'] = categoryId;
      newMap['resturant_id'] = restaurantId;

      if (StaticMethodes.validateName(name, 'نام محصول') &&
          StaticMethodes.validateName(price, 'قیمت')) {
        Dio myDio = Dio();
        await myDio
            .post(
          'http://10.0.2.2:8000/api/admin/products',
          data: newMap,
          options: Options(
            method: 'POST',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            responseType: ResponseType.json,
          ),
        )
            .then((response) {
          if (response.statusCode! < 300) {
            Get.defaultDialog(
              title: '',
              content: Text(
                'اطلاعات شما با موفقیت ذخیره شد.',
                style: kTextStyle,
              ),
            );
            print(response.data);
            nameController.clear();
            priceController.clear();
          }
        });
      }
    }
  }
}
