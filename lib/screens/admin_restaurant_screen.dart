import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/widget/base_widget.dart';

class AdminRestaurantScreen extends StatelessWidget {
  AdminRestaurantScreen({super.key});

  Reastaurant restaurant = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'رستوران${restaurant.title}  ',
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
          Image.network(
            'http://10.0.2.2:8000/image/${restaurant.image}',
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
                restaurant.title ?? '',
                style: kTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 2,),

              const SizedBox(
                height: 20,
              ),
              Text(
                'آدرس',
                style: kTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                restaurant.address ??'',
                style: kTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 2,),

              const SizedBox(
                height: 20,
              ),
              Text(
                'توضیحات',
                style: kTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                restaurant.description ??'',
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
