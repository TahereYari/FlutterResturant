import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/resturant_controller.dart';
import 'package:online_ostore/models/restaurant.dart';
import 'package:online_ostore/services/app_routs.dart';
import 'package:online_ostore/widget/base_widget.dart';

class AdminRestaurantsScreen extends GetView<RestaurantController> {
  const AdminRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'لیست رستوران ها',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(
        () {
          return ListView.separated(
            itemCount: controller.restList.length,
            itemBuilder: (context, index) {
              Reastaurant rest = controller.restList[index];
              return ListTile(
                leading: Image.network(
                  'http://10.0.2.2:8000/image/${rest.image}',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(rest.title ?? ''),
                subtitle: Text(rest.description ?? ''),
                onTap: (){
                  Get.toNamed(AppRoutes.adminRestaurantScreen,arguments: rest);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}
