import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/modules/authentication/forget_password_view.dart';
import 'package:movies_app/core/modules/authentication/login_view.dart';
import 'package:movies_app/core/modules/authentication/register_view.dart';
import 'package:movies_app/core/modules/layout/movie_details/movie_details_view.dart';
import 'package:movies_app/core/modules/layout/profile/edit_profile_view.dart';
import 'package:movies_app/core/modules/on_boarding/fifth_screen.dart';
import 'package:movies_app/core/modules/on_boarding/first_screen.dart';
import 'package:movies_app/core/modules/on_boarding/fourth_screen.dart';
import 'package:movies_app/core/modules/on_boarding/lets_start.dart';
import 'package:movies_app/core/modules/on_boarding/second_screen.dart';
import 'package:movies_app/core/modules/splash/splash_view.dart';
import '../../modules/layout/layout_view.dart';
import '../../modules/on_boarding/third_screen.dart';

abstract class AppRoutesManager {

static Route<dynamic>? onGenerateRoute (RouteSettings settings){

  switch(settings.name) {

    case AppRoutesName.initial:
      return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings);

    case AppRoutesName.letsStart:
      return MaterialPageRoute(
          builder: (context) => const LetsStart(),
          settings: settings);

    case AppRoutesName.firstScreen:
      return MaterialPageRoute(
          builder: (context) => const FirstScreen(),
          settings: settings);

    case AppRoutesName.secondScreen:
      return MaterialPageRoute(
          builder: (context) => const SecondScreen(),
          settings: settings);

    case AppRoutesName.thirdScreen:
      return MaterialPageRoute(
          builder: (context) => const ThirdScreen(),
          settings: settings);

    case AppRoutesName.fourthScreen:
      return MaterialPageRoute(
          builder: (context) => const FourthScreen(),
          settings: settings);

    case AppRoutesName.fifthScreen:
      return MaterialPageRoute(
          builder: (context) => const FifthScreen(),
          settings: settings);
///-------------------------------------------------
    case AppRoutesName.register:
      return MaterialPageRoute(
          builder: (context) => const RegisterView(),
          settings: settings);

    case AppRoutesName.logIn:
      return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings);

    case AppRoutesName.forgetPassword:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView(),
          settings: settings);
  ///-------------------------------------------------
    case AppRoutesName.layout:
      return MaterialPageRoute(
          builder: (context) => const LayoutView(),
          settings: settings);

    case AppRoutesName.movieDetails:
      return MaterialPageRoute(
          builder: (context) => const MovieDetailsView(),
          settings: settings);

    case AppRoutesName.editProfile:
      return MaterialPageRoute(
          builder: (context) => const EditProfileView(),
          settings: settings);

    default:
      return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings);
  }

}
}