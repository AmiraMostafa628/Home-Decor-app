import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdaptiveInputField extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String? title;
  final double heightAfterIt;
  final bool readOnly;
  final String? hintText;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? errorText;
  final TextDirection? textDirection;
  final Widget? prefix;
  final dynamic Function()? prefixPressed;
  final Widget? textFormFieldIcon;
  final String? initialValue;
  final Color? suffixColor;
  final TextInputType? keyboardType;
  final dynamic Function(String)? onSubmit;
  final dynamic Function(String)? onChange;
  final dynamic Function()? onTap;
  final String? Function(String?) validate;
  final bool isPassword;
  final bool? enabled;
  final Widget? suffix;
  final dynamic Function()? suffixPressed;
  final BoxConstraints? constraints;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextAlign? textAlign;
  final int? maxLines;
  final String? counterText;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double radius;
  final bool doOnTapOutside;
  final Color? fillColor;
  final Color? borderSide;
  final Color? hintTextColor;

  const AdaptiveInputField({
    super.key,
    required this.context,
    required this.controller,
    required this.validate,
    this.title,
    this.counterText,
    this.maxLength,
    this.heightAfterIt = 0,
    this.doOnTapOutside = true,
    this.focusNode,
    this.textDirection,
    this.crossAxisAlignment,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.suffixColor,
    this.radius = 10.67,
    this.textFormFieldIcon,
    this.autofocus = false,
    this.readOnly = false,
    this.prefix,
    this.contextMenuBuilder,
    this.initialValue,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.enabled,
    this.suffix,
    this.suffixPressed,
    this.constraints,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.hintText,
    this.isPassword = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
    this.fillColor,
    this.borderSide,
    this.hintTextColor, this.prefixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!, style: Theme.of(context).textTheme.labelLarge),
        if (title != null) SizedBox(height: 10.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          onTapOutside: doOnTapOutside == true
              ? (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          obscureText: isPassword,
          textDirection: textDirection,
          textAlign: textAlign!,
          onFieldSubmitted: onSubmit,
          enabled: enabled,
          autofocus: autofocus,
          onChanged: onChange,
          focusNode: focusNode,
          onTap: onTap,
          contextMenuBuilder: contextMenuBuilder,
          maxLines: isPassword ? 1 : maxLines,
          validator: validate,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium,
          initialValue: initialValue,
          decoration: InputDecoration(
            icon: textFormFieldIcon,
            errorText: errorText,
            fillColor: fillColor ?? ColorManager.primaryColor.withAlpha(70),
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(15),
            constraints: constraints,
            counterText: counterText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: hintTextColor ?? ColorManager.hintTextColor,
            ),
            errorStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.red,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderSide ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderSide ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.primaryColor.withAlpha(70),
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(radius),
            ),
            //border: const UnderlineInputBorder(),
            prefixIcon: prefix != null
                ? IconButton(
                    onPressed: prefixPressed,
                    icon: prefix!,

                  )
                : null,
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: suffix!,
                    color: suffixColor,
                  )
                : null,
          ),
        ),
        SizedBox(height: heightAfterIt),
      ],
    );
  }
}
