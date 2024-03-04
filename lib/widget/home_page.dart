import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/user_controller.dart';
import 'package:online_ostore/screens/search_screen.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/best_restaurant_widget.dart';
import 'package:online_ostore/widget/categories_widget.dart';
import 'package:online_ostore/widget/custom_slider.dart';
import 'package:online_ostore/widget/new_restaurant_widget.dart';

class HomePage extends GetView<UserController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tosegar',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            controller.logOut();

          },
          icon:const Icon(
            Icons.logout_rounded,
            color: kBlackColor,
          ),
        ),
      ),
      padding: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            OpenContainer(
              closedBuilder: (context, action) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: TextField(
                    enabled: false,
                    //  controller: controller.searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kLightGreyColor,
                        prefixIcon: InkWell(
                          // onTap: () {
                          //   controller.search();
                          // },
                          borderRadius: BorderRadius.circular(20),
                          child: const Icon(
                            Icons.search_rounded,
                            size: 20,
                          ),
                        ),
                        hintText: 'جست و جو ...',
                        hintStyle: kTextStyle),
                  ),
                );
              },
              openBuilder: (context, action) {
                return SearchScreen();
              },
              closedElevation: 0,
            ),
            const SizedBox(height: 10,),
            const CustomSlider(),
            const SizedBox(height: 10,),
            const BestRestaurant(),
            const SizedBox(height: 10,),
            const CategoriesWidget(),
            const SizedBox(height: 10,),
            const NewRestaurant(),
            const SizedBox(height: 10,),


          ],
        ),
      ),

    );
  }
}
