import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ostore/constans.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTapped, this.height=67, this.width, this.fontSize, this.color, this.splashColor, this.fontColor});
  final String text;
  final VoidCallback onTapped;
  final double? height;
  final double? width;
  final double? fontSize;

  final Color? color;
  final Color? splashColor;
  final Color? fontColor;



  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(17),
      color: color ?? Colors.amber,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        splashColor:  splashColor ?? Colors.amber,
        highlightColor: Colors.amber.withOpacity(0.1),
        onTap: onTapped,
        child: SizedBox(
          width: Get.width,
          height: height,
         // padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
              child: Text(
                text,
                style: kHeaderText.copyWith(
                  color: fontColor ?? Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize??30,



                ),
              )),
        ),
      ),
    );
  }
}
