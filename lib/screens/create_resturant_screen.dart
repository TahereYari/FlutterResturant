import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/resturant_controller.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/my-text-feild.dart';

class CreateRestaurantScreen extends GetView<RestaurantController> {
  const CreateRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ایجاد رستوران جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),

        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'نام',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              MyTextFeild(controller: controller.nameController,),
             const SizedBox(height: 20,),

              Text(
                'آدرس',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              MyTextFeild(controller: controller.addressController,),
              const SizedBox(height: 20,),

              Text(
                'توضیحات',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              MyTextFeild(controller: controller.descController,),
              const SizedBox(height: 20,),

              Text(
                'نمایش برای اسلاید در صفحه اصلی',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              Center(
                child: Obx(
                    ()=> SizedBox(
                      width: 100,
                      child: DropdownButton(
                        isExpanded: true,
                        value: controller.isSlide.value,
                        style:  kTextStyle,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 0,
                        underline: Container(
                          height: 2,
                          color: Colors.amberAccent,
                        ),
                        items: const[
                          DropdownMenuItem(child: Text('بله'),value: 1,),
                          DropdownMenuItem(child: Text('خیر'),value: 0,),
                        ],
                        onChanged: (int? value) {
                          controller.isSlide.value = value!;
                        },


                      ),
                    ),
                ),
              ),

              const SizedBox(height: 20,),
              Text(
                'تصویر',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),

              GestureDetector(
                onTap: (){
                  controller.selectImage();
                },
                child:  Obx(
                    ()=>Center(
                      child: controller.file.value.path == '-1'
                      ?const CircleAvatar(
                        radius: 40,
                        backgroundColor: kLightYellowColor,
                        child: Icon(Icons.add,
                          size: 36,
                          color: kBlackColor,
                        ),
                      )
                          :Image.file(controller.file.value,
                          width: Get.width,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                      ,
                    ),
                ),
              ),
             const SizedBox(height: 20,),

              CustomButton(
                text: 'ارسال',
                onTapped: () {
                  controller.sendRestaurant();

                },
              ),
              const SizedBox(height: 10,),

            ],
          ),
        ),

    );
  }
}
