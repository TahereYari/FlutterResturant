import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/first.png'),
                fit: BoxFit.cover
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'welcome',
                    style:
                        kHeaderText.copyWith(color: Colors.white, fontSize: 48),
                  ),
                  Text(
                    'to store',
                    style:
                        kHeaderText.copyWith(color: Colors.white, fontSize: 48),
                  ),
                 const SizedBox(height: 20,),
                  Text('Get your groceries as fast as one hour',
                    style: kTextStyle.copyWith(color: Colors.white)),
                  const SizedBox(height: 20,),
                  CustomButton(text: 'Get Started', onTapped: (){
                    Get.offNamed(AppRoutes.logInScreen);
                   // Get.offNamed(AppRoutes.createRestaurant);
                  }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
