import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/basket_screen_controller.dart';
import 'package:online_ostore/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: controller.homeWidget[controller.currentIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          items: const [
            Icon(Icons.home_outlined),
            Icon(Icons.shopping_cart_outlined),
            Icon(Icons.account_circle_outlined),
          ],
          height: 60,
          backgroundColor: Colors.white,
          color: kLightGreyColor,
          buttonBackgroundColor: Colors.amber,
          index: controller.currentIndex.value,
          onTap: (value) {
           controller.changeIndex(value);
          },
          animationDuration: const Duration(milliseconds: 400),
        ),
      ),
    );
  }
}
