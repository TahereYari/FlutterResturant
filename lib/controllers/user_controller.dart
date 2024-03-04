

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_ostore/models/user.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool acceptRule = false.obs;
  late SharedPreferences pref;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString role = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadPref();
    // nameController.dispose();
    // emailController.dispose();
    // passController.dispose();
    // confirmPassController.dispose();
  }
  loadPref()async{
    pref = await SharedPreferences.getInstance();
    name.value = pref.getString('name') ?? '';
    email.value = pref.getString('email') ?? '';
    role.value = pref.getString('role') ?? '';
  }

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }


  void changeAcceptRule() {
    acceptRule.value = !acceptRule.value;
  }

  signUp() async {

    String name = nameController.text;
    String email = emailController.text;
    String password = passController.text;
    if (StaticMethodes.validateName(name,'نام') &&
        StaticMethodes.validateEmail(email) &&
        StaticMethodes.validatePassword(password) &&
        StaticMethodes.validateAcceptRule(acceptRule.value)) {
      try {
        http.Response response =  await http.post(
            Uri.parse('http://10.0.2.2:8000/api/register'),
            body: convert.jsonEncode({
              'name': name,
              'email': email,
              'password': password,
              // 'password-confirmation': password,
            }),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            });
        pref = await SharedPreferences.getInstance();
         Map responseMap = convert.jsonDecode(response.body);
        if (response.statusCode < 300) {

           User user =User.fromJson(responseMap['user']);
           await pref.setString('token', responseMap['token']);
           await pref.setString('email', user.email!);
           await pref.setString('name', user.name!);
           await pref.setInt('user_id', user.id!);
           await pref.setString('role', user.role ?? '');
          Get.offNamed(AppRoutes.introScreen);

        } else {
          List list = responseMap['errors']['email'];
          StaticMethodes.errorSnackBar('خطا', list.first);

        }
      } catch (e, s) {
        print(s);
      }
    }
  }

  logIn() async {
    String email = emailController.text;
    String password = passController.text;
    if (StaticMethodes.validateEmail(email) &&
        StaticMethodes.validatePassword(password)) {
      try {
        http.Response response = await http.post(
            Uri.parse('http://10.0.2.2:8000/api/login'),
            body: convert.jsonEncode({
              'email': email,
              'password': password,
            }),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
        });


       Map responseMap = convert.jsonDecode(response.body.toString());
        pref = await SharedPreferences.getInstance();

        if (response.statusCode < 300) {
          User user =User.fromJson(responseMap['user']);
          await pref.setString('token', responseMap['token']);
          await pref.setString('email', user.email!);
          await pref.setString('name', user.name!);
          await pref.setInt('user_id', user.id!);
          await pref.setString('role', user.role ?? '');
          Get.offNamed(AppRoutes.homeScreen);
        }
        else{
         // StaticMethodes.errorSnackBar('خطا',  responseMap['status']);
          StaticMethodes.errorSnackBar('خطا',  'هیچ کاربری با این اطلاعات وارد شده وجود ندارد.');
        }

      } catch (e, s) {
        print('s');
        print(s);
        print('e');
        print(e);
      }
    }
  }
  logOut() async{
    pref = await SharedPreferences.getInstance();
    await http.get(Uri.parse('http://10.0.2.2:8000/api/logout'),);
    pref.clear();
    Get.offAllNamed(AppRoutes.logInScreen);
    
  }


}
