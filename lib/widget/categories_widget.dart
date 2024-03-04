import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/bast_restaurant_controller.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/models/category.dart';
import 'package:online_ostore/services/app_routs.dart';

class CategoriesWidget extends GetView<BeatRestaurantController> {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دسته بندی ها',
                style: kHeaderText.copyWith(fontSize: 20),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  'مشاهده همه',
                  style: kHeaderText.copyWith(
                    fontSize: 20,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = controller.categories[index];
                  return Container(
                    margin: EdgeInsets.only(
                      right:
                          controller.categories.first.id == category.id ? 0 : 5,
                      left:
                          controller.categories.last.id == category.id ? 0 : 5,
                    ),
                    child:InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      onTap: (){
                        controller.getProductOfCategory(category.id!);
                        Get.toNamed(AppRoutes.categoryScreen,arguments: category);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        width: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/images/img.png'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                category.name!,
                                style: kTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  );
                },
              )),
        ),
      ],
    );
  }
}
