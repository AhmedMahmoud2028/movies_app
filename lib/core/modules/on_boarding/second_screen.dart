import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/modules/widgets/app_button_on_boarding.dart';
import 'package:movies_app/core/modules/widgets/bottom_sheet.dart';
import '../../../main.dart';
import '../../configuration/gen/assets.gen.dart';
import '../../configuration/routes/app_routes_name.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(children: [
        Assets.images.oppenheimer.image(fit: BoxFit.cover),
        Column(children: [
          Spacer(),
          BottomSheets(
            title: "Explore All Genres",
            description: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
            height: 330,
            )
        ],),
        Column(
          spacing: 12,
          children: [
          Spacer(),

          GestureDetector(onTap:(){
            navigatorKey.currentState?.pushNamed(AppRoutesName.thirdScreen);
          },child: AppButtonOnBoarding(buttonText: "Next")),

          GestureDetector(onTap:(){
            navigatorKey.currentState?.pop();
          },child: AppButtonOnBoarding(buttonText: "Back",buttonColor: AppColors.primary,textColor: AppColors.buttonView,)),
          SizedBox(height: 45,)
        ],)



      ],),
    );
  }
}
