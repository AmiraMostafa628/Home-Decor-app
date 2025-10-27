import 'package:decor/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily:'Poppins',
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.whiteColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorManager.whiteColor,
      headerBackgroundColor: ColorManager.primaryColor,
      dividerColor: Colors.transparent

    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.whiteColor
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.primaryColor,
      onPrimary: ColorManager.lightPrimaryColor,
      secondary: ColorManager.primaryColor,
      onSecondary: ColorManager.darkIconColor,
      primaryContainer: ColorManager.lightPrimaryColor,
      error: Colors.red,
      onError: Colors.white,
      surface: ColorManager.lightPrimaryColor.withAlpha(40),
      onSurface: ColorManager.blackColor, // color of text
    ),
    useMaterial3: true,
  );



  static final ThemeData dark = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: ColorManager.primaryColor,
     scaffoldBackgroundColor: Colors.black54,

    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ColorManager.blackColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.blackColor
    ),


    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.primaryColor,
      secondary: ColorManager.darkPrimaryColor,
      onSecondary: ColorManager.darkIconColor,
      surface: Colors.black38,
      onSurface: Colors.white,
      onPrimary: ColorManager.primaryColor,

      error: Colors.red,
      onError: Colors.white,
    ),
    useMaterial3: true,
  );
}
