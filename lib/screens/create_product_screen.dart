import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/productController.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/my-text-feild.dart';

class CreateProduct extends GetView<ProductController> {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ایجاد محصول جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'نام',
              style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            MyTextFeild(
              controller: controller.nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'قیمت',
              style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            MyTextFeild(
              controller: controller.priceController,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'دسته بندی محصول',
              style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Center(
              child: Obx(
                () => SizedBox(
                  width: 100,
                  child: DropdownButton(
                    isExpanded: true,
                    value: controller.dropDownCategoryValue.value,
                    style: kTextStyle,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 0,
                    underline: Container(
                      height: 2,
                      color: Colors.amberAccent,
                    ),
                    items: controller.dropdownCategoryList,
                    onChanged: (int? value) {
                      controller.dropDownCategoryValue.value = value!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'انتخاب رستوران',
              style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Center(
              child: Obx(
                () => SizedBox(
                  width: 200,
                  child: DropdownButton(
                    isExpanded: true,
                    value: controller.dropDownRestaurantValue.value,
                    style: kTextStyle,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 0,
                    underline: Container(
                      height: 2,
                      color: Colors.amberAccent,
                    ),
                    items: controller.dropdownRestaurantList,
                    onChanged: (int? value) {
                      controller.dropDownRestaurantValue.value = value!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              text: 'ارسال',
              onTapped: () {
                controller.createProduct();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
