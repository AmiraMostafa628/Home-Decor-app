import 'package:decor/core/components/simple_text_button.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/local_storage/cache_services.dart';
import 'package:decor/core/services/local_storage/cached_keys.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/onboarding/domain/entities/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.item});

  final Onboarding item;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                item.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              top: 30,
              start: 10,
              child: SimpleTextButton(
                onPressed: () async {
                  await CacheServices.saveCachedData(key: CachedKeys.onBoardingKey, value: true);
                  if(context.mounted) {
                    GoRouter.of(context).go(AppRouter.kLoginView);
                  }
                },
                foregroundColor: ColorManager.blackColor,
                child: Row(
                  spacing: 1,
                  children: [
                    Text(
                      'skip',
                      textScaler: TextScaler.linear(1.0),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 35),
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            item.description,
            textScaler: TextScaler.linear(1.0),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
