import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/bast_restaurant_controller.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/models/restaurant.dart';

class BestRestaurant extends GetView<BeatRestaurantController> {
  const BestRestaurant({super.key});

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
                'بهترین رستوران ها',
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
          height: 230,
          child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.bestList.length,
                itemBuilder: (BuildContext context, int index) {
                  Reastaurant restaurant = controller.bestList[index];
                  return Container(
                    margin: EdgeInsets.only(
                      right:
                      controller.bestList.first.id == restaurant.id ? 0 : 5,
                      left:
                      controller.bestList.last.id == restaurant.id ? 0 : 5,
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: (){
                        Get.find<HomeController>().getRestaurant(restaurant.id!);
                      },
                      child: Container(
                        width: 160,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.network(
                                'http://10.0.2.2:8000/image/${restaurant.image}',
                                height: 120,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                           const SizedBox(
                              height: 2,
                            ),
                            Text(
                              restaurant.title!,
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              restaurant.description!,
                              style: kTextStyle,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  Text(
                                    'امتیاز',
                                    style: kTextStyle,
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      '${(10 - index) / 2 - 0.2}',
                                      style:kTextStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
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
