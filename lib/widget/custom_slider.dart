import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:online_ostore/controllers/home_controller.dart';


class CustomSlider extends GetView<HomeController> {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> SizedBox(
        width: Get.width,
        height: 180,
        child: Stack(children: [
          CarouselSlider(
            items: controller.imageSliders,
            carouselController: controller.carouselController.value,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.2,
                onPageChanged: (index, reason) {
                  controller.onChangeSlide;
                }),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentSlide.value,
              count:  controller.restaurantImageList.length,
              axisDirection: Axis.horizontal,
              effect:  const ExpandingDotsEffect(
                  spacing:  8.0,
                  radius:  4.0,
                  dotWidth:  8.0,
                  dotHeight:  8.0,
                  paintStyle:  PaintingStyle.fill,
                  strokeWidth:  1.5,
                  dotColor:  Colors.grey,
                  activeDotColor:  Colors.white
              ),
              onDotClicked: controller.onDotClick,
            ),
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: controller.restaurantImageList.asMap().entries.map((entry) {
          //     return GestureDetector(
          //       onTap: () => controller.carouselController.value.animateToPage(entry.key),
          //       child: Container(
          //         width: 12.0,
          //         height: 12.0,
          //         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: (Theme.of(context).brightness == Brightness.dark
          //                     ? Colors.white
          //                     : Colors.black)
          //                 .withOpacity(controller.currentSlide.value == entry.key ? 0.9 : 0.4)),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ]),
      ),
    );
  }
}


