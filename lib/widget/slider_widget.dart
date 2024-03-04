import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/models/restaurant.dart';

class SliderWidget extends GetView<HomeController> {
  const SliderWidget({super.key, required this.restaurant});

  final Reastaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onTap: () {
          controller.getRestaurant(restaurant.id!);
        },
        child: Stack(
          children: <Widget>[
            Image.network('http://10.0.2.2:8000/image/${restaurant.image}',
                fit: BoxFit.cover, width: Get.width),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Text(
                  restaurant.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
