import 'package:flutter/material.dart';
import 'package:online_ostore/constans.dart';

class LoadingWiget extends StatelessWidget {
  const LoadingWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kLightBlueColor,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/loading.gif',
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}
