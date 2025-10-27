import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/change_theme_bloc/change_theme_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/change_theme_bloc/change_theme_event.dart';
import 'package:decor/feature/profile/presentation/bloc/change_theme_bloc/change_theme_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:decor/core/services/router/app_router.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.logoutState == RequestState.loaded) {
          Fluttertoast.showToast(
            msg: 'LogOut Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          Future.delayed(Duration(seconds: 3), () {
            if (context.mounted) {
              GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
            }
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 25.0,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      context.go('/');
                    }
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Profile',
                      style: textTheme.headlineSmall!.copyWith(
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
                  builder: (context, themeState) {
                    return IconButton(
                      onPressed: () {
                        ChangeThemeBloc.get(context).add(ToggleThemeEvent());
                      },
                      icon: Icon(
                        themeState.isDark ? Icons.dark_mode : Icons.light_mode,
                        color: themeState.isDark
                            ? Colors.white
                            : Colors.black54,
                      ),
                    );
                  },
                ),
              ],
            ),
            Center(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      state.currentUser.photoUrl ?? AssetsManager.unknown,
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    AppConstants.details
                        .map((item) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(item.navigationLocation);
                            },
                            child: Column(
                              children: [Icon(item.icon), Text(item.title)],
                            ),
                          );
                        })
                        .expand(
                          (widget) => [
                            widget,
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                        .toList()
                      ..removeLast(),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10.0),
                itemCount: AppConstants.profileItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final item = AppConstants.profileItems[index];
                      if (item.title.toLowerCase() == 'logout') {
                        try {
                          AuthBloc.get(context).add(LogoutEvent());
                        } catch (_) {}
                        return;
                      }

                      GoRouter.of(context).push(item.navigationLocation);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: ColorManager.primaryColor,
                        child: Icon(
                          AppConstants.profileItems[index].icon,
                          color: Colors.black54,
                        ),
                      ),
                      title: Text(AppConstants.profileItems[index].title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
