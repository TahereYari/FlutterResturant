import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/basket_screen_controller.dart';
import 'package:online_ostore/models/basket.dart';
import 'package:online_ostore/models/product.dart';
import 'package:online_ostore/static_methods.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/custom_button.dart';
import 'package:online_ostore/widget/loading_widget.dart';

class BasketScreen extends GetView<BasketScreenController> {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'سبد خرید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(
        () => controller.baskets.isEmpty
            ? const Center(
                child: LoadingWiget(),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.restaurant.value.title!,
                        style: kHeaderText.copyWith(
                          fontSize: 22,
                          color: Colors.amber,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.baskets.length,
                          itemBuilder: (context, index) {
                            Product product = controller.products[index];
                            Basket basket = controller.baskets[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  'assets/images/img.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                product.name!,
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(
                                '${basket.count}عدد',
                                style: kTextStyle,
                              ),
                              contentPadding: EdgeInsets.zero,
                              trailing: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      (basket.count! * product.price!)
                                          .toString(),
                                      style: kHeaderText.copyWith(
                                        fontSize: 25,
                                        color: kBlackColor,
                                      ),
                                    ),
                                    Text(
                                      'ریال',
                                      style: kHeaderText.copyWith(
                                        fontSize: 20,
                                        color: kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    width: Get.width - 40,
                    child: CustomButton(
                      text: 'پرداخت',
                      onTapped: () {
                        StaticMethodes.bottomSheetCheckout(
                          controller.basketSum.value.toString(),
                          controller.checkOutController,
                          () {
                            controller.checkout();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
