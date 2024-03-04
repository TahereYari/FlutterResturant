import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/user_controller.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/background_ui.dart';
import 'package:flutter/material.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/my-text-feild.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  final controller = Get.find<UserController>(tag: 'signup');

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
        Text('ثبت نام', style: kHeaderText),
        const SizedBox(
          height: 10,
        ),
        Text(
          'برای ایجاد حساب کاربری اطلاعات خود را وارد کنید.',
          style: kTextStyle,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'نام ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyTextFeild(controller: controller.nameController,height: 30,),
        const SizedBox(
          height: 25,
        ),
        Text(
          'ایمیل ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        MyTextFeild(controller: controller.emailController,height: 30,),
        const SizedBox(
          height: 25,
        ),
        Text(
          'رمز عبور ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 30,
          child: Obx(
                () =>
                TextField(
                  controller: controller.passController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.changeShowPassword();
                      },
                      icon: Icon(controller.showPassword.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_rounded),
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: !controller.showPassword.value,
                  obscuringCharacter: '\u25CF',
                ),
          ),
        ),
        Text(
          'تکرار رمز عبور ',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 30,
          child: TextField(
            controller: controller.confirmPassController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.changeShowPassword();
                },
                icon: Icon(controller.showPassword.value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_rounded),
                color: Colors.grey,
              ),
            ),
            obscureText: true,
            obscuringCharacter: '\u25CF',
          ),
        ),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            title: RichText(
              text: TextSpan(
                style: kTextStyle.copyWith(
                  fontSize: 16,
                  color: kBlackColor,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: 'با'),
                  TextSpan(
                    text: ' شرایط و قوانین ',
                    style: const TextStyle(
                      color: kGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(
                          AppRoutes.signUpScreen,
                        );
                      },
                  ),
                  const TextSpan(text: 'برنامه موافقم'),
                ],
              ),
            ),
            leading: Obx(
                  () =>
                  PageTransitionSwitcher(
                      transitionBuilder: (Widget child,
                          Animation<double> primaryAnimation,
                          Animation<double> secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: controller.acceptRule.value
                          ? const SizedBox(child: Icon(
                        Icons.check_circle_outline, color: Colors.green,),)
                          :const Icon(Icons.check_circle_outline),
                    duration: const Duration(milliseconds: 800),
                  ),
            ),
            onTap: () {
              controller.changeAcceptRule();
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: 'ثبت نام',
          onTapped: () {
            controller.signUp();

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
              children: [
                const TextSpan(text: 'حساب کاربری دارید؟'),
                TextSpan(
                  text: 'ورود',
                  style: const TextStyle(
                    color: kGreenColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offNamed(AppRoutes.logInScreen);
                    },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
