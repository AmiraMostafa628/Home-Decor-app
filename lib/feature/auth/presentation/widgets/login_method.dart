import 'package:decor/core/components/simple_text_button.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginMethod extends StatelessWidget {
  const LoginMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        spacing: 10.0,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "or",
            textScaler: TextScaler.linear(1.0),
            textAlign: TextAlign.center,
          ),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.facebookIcon,
              ),
              Image.asset(
                AssetsManager.googleIcon,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account?",
                textScaler: TextScaler.linear(1.0),
              ),
              SimpleTextButton(
                onPressed: () {
                  GoRouter.of(context).push(
                    AppRouter.kSignUpView,
                  );
                },
                foregroundColor: ColorManager.darkPrimaryColor,
                child: Text(
                  "SignUp",
                  textScaler: TextScaler.linear(1.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
