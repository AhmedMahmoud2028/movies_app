import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/gen/assets.gen.dart';

import '../../../main.dart';
import '../../configuration/routes/app_routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  late Timer _timer ;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
        Duration(seconds: 3), (){
      navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.logIn);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 280,),
          Assets.images.moviesLogo.image(
            width: 250,
            height: 250
          ),
          Spacer(),



          Assets.images.routeLogo.image(
            height: 75,
            width: 180
          ),
        ],),
      ),
    );

  }
}
