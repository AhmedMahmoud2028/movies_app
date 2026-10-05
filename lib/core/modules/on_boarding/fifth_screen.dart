import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/modules/widgets/app_button_on_boarding.dart';
import 'package:movies_app/core/modules/widgets/bottom_sheet.dart';
import '../../../main.dart';
import '../../configuration/gen/assets.gen.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(children: [
        Assets.images.warFilm.image(fit: BoxFit.cover),
        Column(children: [
          Spacer(),
          BottomSheets(
            title: "Start Watching Now",
            height: 260,
          )
        ],),
        Column(
          spacing: 12,
          children: [
            Spacer(),

            GestureDetector(onTap:(){
              navigatorKey.currentState?.pushNamed(AppRoutesName.logIn);
            },child: AppButtonOnBoarding(buttonText: "Finish")),

            GestureDetector(onTap:(){
              navigatorKey.currentState?.pop();
            },child: AppButtonOnBoarding(buttonText: "Back",buttonColor: AppColors.primary,textColor: AppColors.buttonView,)
             ),
            SizedBox(height: 45,)
          ],)



      ],),
    );
  }
}
