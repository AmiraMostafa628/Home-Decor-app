import 'package:decor/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key, required this.errMessage,});
  final String errMessage;



  @override
  Widget build(BuildContext context) {
    return  Column(
      spacing: 10.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AssetsManager.emptyList,
          width: 300,
          height: 300,
          fit: BoxFit.cover,

        ),
        Text(
          errMessage,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}