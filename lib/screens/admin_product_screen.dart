import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/productController.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/base_widget.dart';

class AdminProductList extends GetView<ProductController> {
  const AdminProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'لیست محصولات',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(() {
        return ListView.separated(
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            Product product = controller.productList[index];
            String? productCategory = controller.categoryList
                .where((category) => category.id == product.categoryId)
                .first
                .name;
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.amberAccent,
                child: Text(
                  (index + 1).toString(),
                  style: kHeaderText.copyWith(fontSize: 25),
                ),
              ),
              title: Text(
                product.name ?? '',
                style: kHeaderText.copyWith(fontSize: 20),
              ),
              subtitle: Text(
                productCategory ?? '',
                style: kTextStyle.copyWith(fontSize: 14),
              ),
              trailing: Text(
                ' قیمت:  ${product.price} تومان',
                style: kTextStyle.copyWith(fontSize: 14),
              ),
              onTap: () {
                Get.toNamed(
                  //AppRoutes.productScreen,
                  //روش دیگر ارسال پارامتر
                  '${AppRoutes.productScreen}?categoryName=$productCategory',
                  arguments: product,
                // parameters: {'categoryName': productCategory!},
                );
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      }),
    );
  }
}
