import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/modules/widgets/app_button_on_boarding.dart';
import 'package:movies_app/core/modules/widgets/bottom_sheet.dart';
import 'package:movies_app/main.dart';
import '../../configuration/gen/assets.gen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: GestureDetector(onTap:(){
        navigatorKey.currentState?.pushNamed(AppRoutesName.secondScreen);
      },child: AppButtonOnBoarding(buttonText: "Next")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: [
        Assets.images.avengers.image(fit: BoxFit.cover),
        Column(children: [
          Spacer(),
          BottomSheets(
            title: "Discover Movies",
            description: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
            height: 260,
            )
        ],),
        



      ],),
    );
  }
}
