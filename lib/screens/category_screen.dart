import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/bast_restaurant_controller.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/loading_widget.dart';

class CategoryScreen extends GetView<BeatRestaurantController> {
  CategoryScreen({super.key});

  Category category = Get.arguments;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category.name!,
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          ),
        ),
      ),
      child: Obx(
        () => controller.products.isEmpty
            ? Center(
                child: LoadingWiget(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  Product product = controller.products[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/img.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    title: Text(
                      product.name!,
                      style: kTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      product.price.toString(),
                      style: kTextStyle,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Get.find<HomeController>().addToCart(product.id!,product.resturantId!);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
