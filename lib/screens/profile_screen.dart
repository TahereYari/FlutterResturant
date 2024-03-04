import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';
import 'package:online_ostore/controllers/user_controller.dart';
import 'package:online_ostore/widget/base_widget.dart';
import 'package:online_ostore/widget/custom_button.dart';

class ProfileScreen extends GetView<UserController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/img.png'),
                radius: 25,
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.name.value,
                    style: kHeaderText.copyWith(color: kBlackColor,fontSize: 20),
                  ),
                  Text(
                    controller.email.value,
                    style: kTextStyle.copyWith(color: kBlackColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      padding: 0,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'رستوران های ذخیره شده',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'روش های پرداخت',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'لیست مورد علاقه ها',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'آدرس های من',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'سوابق خرید',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'ارتباط با پشتیبانی',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: kLightGreyColor),
              bottom: BorderSide(color: kLightGreyColor),
            )),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'درباره ما',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'خروج از حساب',
            onTapped: () {
              controller.logOut();
            },
            color: kLightGreyColor,
            splashColor: Colors.grey,
            fontColor: Colors.amber,
            fontSize: 25,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
