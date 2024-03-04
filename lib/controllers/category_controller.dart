import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  sendCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? '-1';
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String desc = descController.text;
      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['description'] = desc;
      print('newmap');
      print(newMap);

      if (StaticMethodes.validateName(name, 'نام دسته بندی') &&
          StaticMethodes.validateName(desc, 'توضیحات')) {
        dio.Dio myDio = dio.Dio();
       dio.Response response = await myDio.post(
         'http://10.0.2.2:8000/api/admin/categories',
          data: newMap,
          options: dio.Options(
            method: 'POST',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',

            },
            // followRedirects: false,
            // validateStatus: (status) { return status! < 400; },

           responseType: dio.ResponseType.json,

          ),
        );
       print('response.statusCode');
       print(response.statusCode);
       print('response.data');
       print(response.data);
      }
    }
  }
}
