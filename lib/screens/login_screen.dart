import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/user_controller.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/background_ui.dart';
import 'package:flutter/material.dart';
import 'package:online_ostore/widget/custom_button.dart';


class LogInScreen extends StatelessWidget {
   LogInScreen({super.key});
  final controller = Get.find<UserController>(tag: 'login');



  @override
  Widget build(BuildContext context) {
    return BackgroundUI(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text('ورود', style: kHeaderText),
        const SizedBox(
          height: 10,
        ),
        Text(
          'لطفا برای ورود، ایمیل و رمز عبور خود را وارد کنید.',
          style: kTextStyle,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'ایمیل ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 40,
          child: TextField(
           controller: controller.emailController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'رمز عبور ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 40,
          child: Obx(
    ()=> TextField(
      controller: controller.passController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.changeShowPassword();
                  },
                  icon: Icon(
                      controller.showPassword.value
                          ?Icons.remove_red_eye_outlined
                          :Icons.visibility_off_rounded),
                  color: Colors.grey,
                ),
              ),
              obscureText: !controller.showPassword.value,
              obscuringCharacter: '\u25CF',
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'رمز عبور خود را فراموش کرده اید؟ ',
            style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kBlackColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: 'ورود',
          onTapped: () {
            controller.logIn();

          },
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: kBlackColor,
                fontWeight: FontWeight.bold,
              ),
              children:  [
                const TextSpan(text: 'حساب کاربری ندارید؟'),
                TextSpan(
                  text: 'ثبت نام',
                  style: const TextStyle(
                    color: kGreenColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap=(){
                    Get.offNamed(AppRoutes.signUpScreen,);

                  } ,

                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
