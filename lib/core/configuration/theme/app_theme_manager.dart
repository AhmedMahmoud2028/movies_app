import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';

abstract class AppThemeManager {

  static ThemeData appTheme() => ThemeData(

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          //statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark
        ),
      ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      backgroundColor: AppColors.primary,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
      )


    ),

    textTheme: TextTheme(

      /// Size 34
      headlineMedium: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
        color: AppColors.textMain

      ),

      /// size 24
      headlineSmall: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        color: AppColors.textMain

      ),

      /// Size 20
      titleLarge: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w600,
        color: AppColors.textMain
      ),

      /// Size 16
      bodyLarge: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        color: AppColors.textSecond,
      ),

      /// Size14
      bodyMedium: TextStyle( ),


    )





  );
}