import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/profile/presentation/widgets/format_card_number.dart';
import 'package:decor/core/components/adaptive_input_field.dart';
import 'package:flutter/material.dart';

class CardNumberField extends StatelessWidget {
  CardNumberField({super.key, required this.cardNumber, required this.title});

  final cardNumberController = TextEditingController();
  late final Function(String) cardNumber;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AdaptiveInputField(
      context: context,
      title: title,
      controller: cardNumberController,
      keyboardType: TextInputType.number,
      hintText: '---- ---- ---- ----',
      hintTextColor: const Color(0xffA0A5BA),
      fillColor: ColorManager.lightPrimaryColor,
      borderSide: Colors.transparent,
      radius: 12,
      inputFormatters: [FormatCardNumber()],
      onChange: (value) {
        cardNumber(value);
      },
      validate: (value) {
        return null;
      },
    );
  }
}
