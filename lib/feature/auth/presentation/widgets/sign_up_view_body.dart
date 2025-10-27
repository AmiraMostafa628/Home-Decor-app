import 'package:decor/core/components/adaptive_input_field.dart';
import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/components/simple_text_button.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/core/services/validation/confirm_password_validation_service.dart';
import 'package:decor/core/services/validation/date_of_birth_validation_service.dart';
import 'package:decor/core/services/validation/email_validation_service.dart';
import 'package:decor/core/services/validation/mobile_number_validation_service.dart';
import 'package:decor/core/services/validation/password_validation_service.dart';
import 'package:decor/core/services/validation/user_name_validation_service.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_event.dart';
import 'package:decor/feature/auth/presentation/manager/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({super.key});

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final dateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.date.isNotEmpty) {
          dateController.text = state.date;
          formKey.currentState!.validate();
        }
        if (state.signUpState == RequestState.loaded) {
          Fluttertoast.showToast(
            msg:
                "Welcome aboard! Please verify your email to activate your account.",
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

        if (state.signUpState == RequestState.error) {
          Fluttertoast.showToast(
            msg: state.signUpErrorMessage ?? '',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Create Account',
                          textScaler: TextScaler.linear(1.0),
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.primaryColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: InkWell(
                    onTap: () {
                      AuthBloc.get(context).add(PickImageEvent());
                    },
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: state.profileFile != null
                          ? FileImage(state.profileFile!)
                          : null,
                      child: state.profileFile == null
                          ? Icon(
                              Icons.add_a_photo,
                              color: ColorManager.primaryColor,
                            )
                          : null,
                    ),
                  ),
                ),

                AdaptiveInputField(
                  context: context,
                  title: 'Full name',
                  hintText: 'john Doe',
                  controller: fullNameController,
                  heightAfterIt: 20.0,
                  validate: (value) {
                    return isUserNameValid(userName: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  title: "Email Address",
                  hintText: 'example@gmail.com',
                  controller: emailController,
                  heightAfterIt: 20.0,
                  validate: (value) {
                    return isEmailValid(email: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  title: 'Mobile Number',
                  hintText: '+ 123 456 789',
                  controller: mobileController,
                  heightAfterIt: 20.0,
                  validate: (value) {
                    return isMobileNumberValid(mobileNumber: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  readOnly: true,
                  onTap: () {
                    AuthBloc.get(context).add(PickDateEvent(context: context));
                  },
                  title: 'Date of birth',
                  hintText: 'DD / MM /YYY',
                  controller: dateController,
                  heightAfterIt: 20.0,
                  validate: (value) {
                    return dateOfBirthValid(dateOfBirth: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  title: 'Password',
                  hintText: '******',
                  controller: passwordController,
                  heightAfterIt: 20.0,
                  isPassword: state.signUpPasswordVisibility,
                  suffix: Icon(
                    state.signUpPasswordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorManager.hintTextColor,
                  ),
                  suffixPressed: () {
                    AuthBloc.get(context).add(SignUpPasswordVisibilityEvent());
                  },
                  validate: (value) {
                    return isPasswordValid(password: value);
                  },
                ),
                AdaptiveInputField(
                  context: context,
                  title: 'Confirm Password',
                  hintText: '*****',
                  controller: confirmPasswordController,
                  heightAfterIt: 20.0,
                  isPassword: state.signUpConfirmPasswordVisibility,
                  suffix: Icon(
                    state.signUpConfirmPasswordVisibility
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: ColorManager.hintTextColor,
                  ),
                  suffixPressed: () {
                    AuthBloc.get(
                      context,
                    ).add(SignUpConfirmPasswordVisibilityEvent());
                  },
                  validate: (value) {
                    return matchPassword(
                      value: value,
                      password: passwordController.text,
                    );
                  },
                ),
                Center(
                  child: SizedBox(
                    width: 240,
                    child: RichText(
                      textScaler: TextScaler.linear(1.0),
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing, you agree to ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Terms of Use  ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                state.signUpState == RequestState.loading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: CustomTextButton(
                          upperCase: false,
                          width: 220,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              AuthBloc.get(context).add(
                                SignUpEvent(
                                  signUpEntity: SignUpEntity(
                                    name: fullNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    mobileNumber: mobileController.text,
                                    dateOfBirth: dateController.text,
                                    photoUrl:
                                        state.profileUrl ??
                                        AssetsManager.unknown,
                                  ),
                                ),
                              );
                            }
                          },
                          text: 'Sign Up',
                        ),
                      ),
                const SizedBox(height: 10.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Or', textScaler: TextScaler.linear(1.0)),
                  ),
                ),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AssetsManager.facebookIcon),
                    Image.asset(AssetsManager.googleIcon),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already ave an Account',
                      textScaler: TextScaler.linear(1.0),
                    ),
                    SimpleTextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kLoginView);
                      },
                      foregroundColor: ColorManager.darkPrimaryColor,
                      child: Text('Log in', textScaler: TextScaler.linear(1.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
