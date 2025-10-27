import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final  String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/');
            }
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      Expanded(
        child: Center(
          child: Text(title,
            style: textTheme.headlineSmall!.copyWith(
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),

      ],
    );
  }
}
