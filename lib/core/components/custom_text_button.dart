import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.borderRadius,
    required this.text,
    this.fontSize,
    this.onPressed,
    this.height,
    this.upperCase = true,
    this.fontWeight,
    this.backGroundColor,
    this.fontColor, this.width,
  });

  final BorderRadius? borderRadius;
  final String text;
  final double? fontSize;
  final Color? fontColor;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final bool upperCase;
  final FontWeight? fontWeight;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width?? double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backGroundColor ?? ColorManager.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          upperCase ? text.toUpperCase() : text,
          textScaler: TextScaler.linear(1.0),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: fontSize ?? 20,
            fontWeight:  FontWeight.w600,
            color: fontColor??ColorManager.darkPrimaryColor,
          ),
        ),
      ),
    );
  }
}
