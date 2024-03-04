import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/home_controller.dart';
import 'package:online_ostore/controllers/search_screen_controller.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/base_widget.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.searchController.clear();
        controller.restList.clear();
        return true;
      },
      child: BaseWidget(
        child: SafeArea(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: kLightGreyColor,
                        prefixIcon: InkWell(
                          onTap: () {
                            controller.search();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: const Icon(
                            Icons.search_rounded,
                            size: 20,
                          ),
                        ),
                        hintText: 'جست و جو ...',
                        hintStyle: kTextStyle,),
                  ),
                ),
                if (controller.restList.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Text(
                        'برای پیدا کردن رستوران خود جستجو کنید.',
                        style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    // child: ListView.builder(
                    //   itemCount: controller.restList.length,
                    //     itemBuilder: (context, index) {
                    //       Reastaurant rest = controller.restList[index];
                    //       return ListTile(
                    //         leading: Image.network(
                    //           'http://10.0.2.2:8000/image/${rest.image}',
                    //           width: 60,
                    //           height: 60,
                    //           fit: BoxFit.cover,
                    //         ),
                    //         title: Text(rest.title ?? ''),
                    //         subtitle: Text(rest.description ?? ''),
                    //         onTap: (){
                    //           Get.toNamed(AppRoutes.restaurantScreen,arguments: rest);
                    //         },
                    //
                    //       );
                    //     },),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: List.generate(
                        controller.restList.length,
                        (index) {
                          Reastaurant rest = controller.restList[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Future.delayed(Duration(milliseconds: 100),
                                  (){
                                    Get.find<HomeController>().getRestaurant(rest.id!);
                                  },
                              );

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: controller.color[controller.random.nextInt(7)],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.redAccent,
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 10,
                                left: 10,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      'http://10.0.2.2:8000/image/${rest.image}',
                                      height: 80,
                                      width: Get.width,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      rest.title!,
                                      style: kHeaderText.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      rest.description!,
                                      style: kHeaderText.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
