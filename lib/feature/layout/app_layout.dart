import 'package:decor/core/resources/theme_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/core/services/services_locator/services_locator.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_event.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_bloc.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_event.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_event.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/change_theme_bloc/change_theme_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/change_theme_bloc/change_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(
            loginUseCase: sl(),
            signUpUseCase: sl(),
            logoutUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeBloc(sl(), sl(), sl(), sl())
            ..add(SliderEvent())
            ..add(CategoriesEvent())
            ..add(ProductsEvent())
            ..add(GetCurrentUserEvent()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              CartBloc(sl(), sl())..add(FetchCartEvent()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              FavBloc(sl(), sl())..add(FetchFavEvent()),
        ),
        BlocProvider(
          create: (context) {
            return ProfileBloc();
          },
        ),
        BlocProvider(create: (_) => ChangeThemeBloc()),
      ],
      child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
        builder: (context, themeState) {
          final isDark = themeState.isDark;
          return ScreenUtilInit(
            designSize: Size(412, 915),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.createRouter(),
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.dark,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                builder: (context, child) => AnimatedTheme(
                  data: isDark ? AppTheme.dark : AppTheme.lightTheme,
                  duration: const Duration(milliseconds: 400),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
