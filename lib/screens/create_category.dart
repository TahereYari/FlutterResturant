import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/category_controller.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/my-text-feild.dart';

class CreateCategory extends GetView<CategoryController> {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ایجاد دسته بندی جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60,),
          Text(
            'نام',
            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          MyTextFeild(controller: controller.nameController,),
          const SizedBox(height: 20,),

          Text(
            'توضیحات',
            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          MyTextFeild(controller: controller.descController,),
          const SizedBox(height: 60,),


          CustomButton(
            text: 'ارسال',
            onTapped: () {
              controller.sendCategory();

            },
          ),
          const SizedBox(height: 10,),


        ],
      ),
    );
  }
}
