
import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/app_text.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final Color color;
  String? text;
  IconData? icon;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  bool? isIcon;

  AppButton(
      {super.key,
      this.text ,
      this.icon,
      this.isIcon = false,
      required this.size,
      required this.color,
      required this.backgroundColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: size,
      height: size,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor),
      child: isIcon == false ? Center(child: AppText(text: text!, color: color,)) : Center(child: Icon(icon, color: color,)),
    );

  }
}
