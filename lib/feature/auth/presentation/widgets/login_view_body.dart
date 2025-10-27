import 'package:decor/core/components/adaptive_input_field.dart';
import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/components/simple_text_button.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/core/services/validation/password_validation_service.dart';
import 'package:decor/core/services/validation/user_name_validation_service.dart';
import 'package:decor/feature/auth/domain/entities/login_entity.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.loginState == RequestState.loaded) {
            Fluttertoast.showToast(
              msg: 'Login Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0,
            );
            Future.delayed(Duration(seconds: 3), () {
              if (context.mounted) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            });
        }
        if (state.loginState == RequestState.error) {
          Fluttertoast.showToast(
            msg: state.loginErrorMessage ?? '',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Log in',
                    textScaler: TextScaler.linear(1.0),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Welcome',
                  textScaler: TextScaler.linear(1.0),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'Please enter your details to proceed.',
                  textScaler: TextScaler.linear(1.0),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 50.0),
                AdaptiveInputField(
                  context: context,
                  title: 'Username or email',
                  hintText: 'example@gmail.com',
                  controller: emailController,
                  heightAfterIt: 30.0,
                  validate: (value) {
                    return isUserNameValid(userName: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  title: 'Password',
                  hintText: '**********',
                  controller: passwordController,
                  isPassword: state.loginPasswordVisibility,
                  suffix: Icon(
                    state.loginPasswordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorManager.hintTextColor,
                  ),
                  suffixPressed: () {
                    AuthBloc.get(context).add(LoginPasswordVisibilityEvent());
                  },
                  heightAfterIt: 40.0,
                  validate: (value) {
                    return isPasswordValid(password: value);
                  },
                ),
                state.loginState == RequestState.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ),
                      )
                    : Center(
                        child: CustomTextButton(
                          upperCase: false,
                          width: 220,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthBloc.get(context).add(
                                LoginEvent(
                                  loginEntity: LoginEntity(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          text: 'Log in',
                        ),
                      ),
                const SizedBox(height: 10.0),
                Center(
                  child: SimpleTextButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kForgetPasswordView);
                    },
                    foregroundColor: ColorManager.blackColor,
                    child: Text('Forget Password?'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
