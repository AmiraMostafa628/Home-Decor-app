import 'package:decor/feature/auth/presentation/widgets/login_method.dart';
import 'package:decor/feature/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: LoginViewBody(),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: LoginMethod(),
            ),
          ],
        ),
      ),
    );
  }
}
