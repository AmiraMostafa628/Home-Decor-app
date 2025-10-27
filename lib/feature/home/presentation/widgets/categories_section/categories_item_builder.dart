import 'package:decor/core/components/custom_image.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CategoriesItemBuilder extends StatelessWidget {
  const CategoriesItemBuilder({super.key, required this.data});

  final CategoryEntity data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 10.0,
      children: [
        GestureDetector(
          onTap: (){
            GoRouter.of(context).push(AppRouter.kSubCategoriesView,extra: data);

          },
          child: Container(
            padding: EdgeInsets.all(18),
            height: 70,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorManager.lightPrimaryColor,
            ),
           child: CustomImage(
             width: 20,
             height: 20,
             imageType: ImagesType.network,
             imagePath: data.image,
             color: ColorManager.primaryColor,
           ),

          ),
        ),
        Text(
          data.name,
          style: textTheme.bodySmall!.copyWith(),
        ),
      ],
    );
  }
}
