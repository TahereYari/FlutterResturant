import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/productController.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/widget/base_widget.dart';

class ProductScreen extends GetView<ProductController> {
   ProductScreen({super.key});

  Product product = Get.arguments;
  String categoryName = Get.parameters['categoryName']!;
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${product.name}  ',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon:const Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          ),
        ),
      ),
      padding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/img.png',
            height: 200,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Padding(padding:const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ const SizedBox(
                height: 30,
              ),
                Text(
                  'نام',
                  style: kHeaderText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                 product.name ?? '',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 2,),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  'قیمت',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.price.toString(),
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 2,),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  'دسته بندی',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  categoryName,
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 2,),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
