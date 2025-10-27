import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final TextEditingController textEditingController;
  final double? borderRadius;
  final double? height;
  final Widget? prefixIcon;
  final dynamic suffixIcon;
  final Color? filledColor;
  final Color? hintColor;
  final Widget? widget;
  final TextInputType? type;
  final bool? isPassword;
  final FormFieldValidator? validate;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool? readOnly;
  final double? spacing;

  const CustomTextFormField({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    required this.textEditingController,
    this.borderRadius,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.filledColor,
    this.hintColor,
    this.widget,
    this.type,
    this.isPassword,
    this.validate,
    this.onChange,
    this.onTap,
    this.readOnly,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: type ?? TextInputType.text,
        readOnly: readOnly ?? false,
        obscureText: isPassword ?? false,
        onTap: onTap,
        validator: validate,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: const Color(0xff32343E),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 14.0,
          ),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          filled: true,
          fillColor: filledColor ?? ColorManager.primaryColor.withAlpha(70),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
          hintText: text,
          hintStyle: TextStyle(
            color: hintColor?? ColorManager.hintTextColor,
          ),
          suffixIcon: suffixIcon,
        ),
        onChanged: onChange,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 20),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}
