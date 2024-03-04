import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
   SplashScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(
              height: 50,
            ),
            const Text('ToseGar'),
            // Image.asset('name'),
            const SizedBox(
              height: 50,
            ),
            const Text('online market'),
            // Image.asset('name'),


          ],
        ),

      ),

    );
  }
}
