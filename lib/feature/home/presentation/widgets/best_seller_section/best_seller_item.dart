import 'package:decor/core/components/custom_image.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BestSellerItem extends StatelessWidget {
  const BestSellerItem({super.key, required this.bestSeller});

  final ProductEntity bestSeller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              Text(
                bestSeller.name,
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorManager.blackColor

                ),
              ),
              SizedBox(
                width: 210.0,
                child: Text(
                  bestSeller.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall!.copyWith(
                      color: ColorManager.blackColor

                  ),

                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 70.0,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 7.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorManager.whiteColor,
                    ),
                    child: Row(
                      spacing: 4.0,
                      children: [
                        Icon(
                          Icons.star,
                          color: ColorManager.primaryColor,
                        ),
                        Text(
                          '4.5',
                          style: textTheme.bodyMedium!.copyWith(
                            color: ColorManager.blackColor
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      GoRouter.of(context).push(AppRouter.kProductDetails,extra: bestSeller);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 7.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ColorManager.whiteColor
                      ),
                      child: Text(
                        'Shop Now',
                        style: textTheme.bodyMedium!.copyWith(
                          color: ColorManager.blackColor
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -50,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomImage(
              imageType: ImagesType.network,
              width: 150,
              height: 120,
              imagePath: bestSeller.image,
              boxFit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
