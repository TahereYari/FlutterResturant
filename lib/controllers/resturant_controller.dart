import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Rx<File> file = File('-1').obs;
  RxInt isSlide = 0.obs;
  late SharedPreferences pref;
  String token = '-1';

  //String role = 'user';
  RxList<Reastaurant> restList = <Reastaurant>[].obs;

  onInit() {
    super.onInit();
    getRestaurantList();
  }

  getRestaurantList() async {
    await getToken();
    dio.Dio myDio = dio.Dio();
    dio.Response response = await myDio.get(
      'http://10.0.2.2:8000/api/admin/resturants',
      options: dio.Options(
        method: 'Get',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        responseType: dio.ResponseType.json,
      ),
    );
    if (response.statusCode! < 300) {
      for (var item in response.data['data']) {
        restList.add(
          Reastaurant.fromJson(item),
        );
      }

    }
    else{
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    }
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
  }

  Future<void> selectImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile _pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery) ??
            XFile('-1');
    if (_pickedImage.path != '-1') {
      file.value = File(_pickedImage.path);
    }
  }

  sendRestaurant() async {
    getToken();

    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String address = addressController.text;
      String desc = descController.text;
      int slide = isSlide.value;
      Map<String, dynamic> newMap = {};

      newMap['title'] = name;
      newMap['address'] = address;
      newMap['description'] = desc;
      newMap['is_list'] = slide;

      if (StaticMethodes.validateName(name, 'نام رستوران') &&
          StaticMethodes.validateName(address, 'آدرس') &&
          StaticMethodes.validateName(desc, 'توضیحات')) {
        if (file.value.path == '-1') {
          StaticMethodes.errorSnackBar('خطا', 'لطفا یک تصویر انتخاب کنید');
          return;
        } else {
          newMap['image'] = await dio.MultipartFile.fromFile(file.value.path,
              filename: file.value.path.split('/').last);
        }
        dio.Dio myDio = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap(newMap);
        dio.Response response = await myDio.post(
          'http://10.0.2.2:8000/api/admin/resturants',
          data: formData,
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            method: 'POST',
            responseType: dio.ResponseType.json,
          ),
        );

        if (response.data == '') {
          Get.defaultDialog(
            title: '',
            content: Text(
              'اطلاعات شما با موفقیت ذخیره شد.',
              style: kTextStyle,
            ),
          );
          reset();
        } else {
          StaticMethodes.errorSnackBar('خطا', 'نام رستوران تکراری می باشد.');
          print('response.data');
          print(response.data);
        }
      }
    }
  }

  void reset() {
    nameController.clear();
    addressController.clear();
    descController.clear();
    isSlide.value = 0;
    file.value = File('-1');
  }
}
