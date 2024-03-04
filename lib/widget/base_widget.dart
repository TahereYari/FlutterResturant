import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, this.appBar, required this.child, this.padding, this.backgroundColor, });

  final AppBar? appBar;
  final Widget child;
  final double? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: padding ?? 20.0),
        child: child,
      ),
    );
  }
}
