import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/my-text-feild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaticMethodes {
  ///show the snack bar for errors in app
  static void errorSnackBar(String title, String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: kHeaderText,
      ),
      messageText: Text(
        message,
        style: kTextStyle,
      ),
      backgroundColor: Colors.redAccent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    );
  }

  static bool validateName(String name, String title) {
    if (name.isEmpty) {
      errorSnackBar('خطا', 'لطفا $title راوارد کنید.');
      return false;
    }
    return true;
  }

  static bool validateEmail(String email) {
    if (email.isEmpty) {
      errorSnackBar('خطا', 'لطفا ایمیل راوارد کنید.');
      return false;
    } else {
      bool status = GetUtils.isEmail(email);
      //اگر فرمت ایمیل را داشت
      if (!status) {
        errorSnackBar('خطا', 'لطفا ایمیل را صحیح راوارد کنید.');
        return false;
      }
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.isEmpty || password.length < 8) {
      errorSnackBar('خطا', 'لطفا رمز عبور را صحیح راوارد کنید.');
      return false;
    }
    return true;
  }

  static bool validateAcceptRule(bool acceptRule) {
    if (!acceptRule) {
      errorSnackBar('خطا', 'لطفا قوانین را تایید کنید');
      return false;
    }
    return true;
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
    return token;
  }

  static void errorDialogRestaurant(
      {required Reastaurant restaurant,
      required VoidCallback onChangeRestaurant}) {
    Get.defaultDialog(
        title: 'اخطار ',
        content: Text(
          'شما از رستوران ${restaurant.title} یک خرید دارید آیا قصد تغییر رستوران خود را دارید؟',
          style: kTextStyle,
          textAlign: TextAlign.center,
        ),
        confirm: InkWell(
          onTap: () {
            Get.back();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Center(
            heightFactor: 1.5,
            child: Text(
              'ادامه خرید',
              style: kHeaderText.copyWith(fontSize: 22),
            ),
          ),
        ),
        cancel: CustomButton(
          text: 'تغییر رستوران',
          height: 50,
          fontSize: 22,
          onTapped: onChangeRestaurant,
        ));
  }

  static bottomSheetCheckout(
      String sum, TextEditingController controller, VoidCallback onTap) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'پرداخت',
                    style: kHeaderText,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const Divider(),
              Text(
                'جمع مبلغ خرید شما برابر است با',
                style: kTextStyle.copyWith(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '$sumریال',
                style: kHeaderText,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      'مبلغ دلخواه خود را جهت شارژ کیف پول خود وارد کنید.',
                      style: kTextStyle,
                    ),
                  ),
                  Expanded(
                    child: MyTextFeild(
                      controller: controller,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(text: 'پرداخت', onTapped: onTap),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  static succesDialog(String text) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Image.asset(
            'assets/images/img.png',
            height: 200,
            width: 200,
          ),
         const SizedBox(height: 20,),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          )
        ],
      ),


    );
  }

  static unSuccesDialog(String text) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Image.asset(
            'assets/images/img.png',
            height: 200,
            width: 200,
          ),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          )
        ],
      ),
      confirm: InkWell(
        onTap: () {
          Get.back();
          FocusManager.instance.primaryFocus?.unfocus();
          Get.back();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          heightFactor: 1.5,
          child: Text(
            'برگشت',
            style: kHeaderText.copyWith(
              fontSize: 22,
            ),
          ),
        ),
      ),
      cancel: CustomButton(
        text: 'دوباره امتحان کنید.',
        height: 50,
        fontSize: 22,
        onTapped: () {
          Get.back();
        },
      ),
    );
  }
}
