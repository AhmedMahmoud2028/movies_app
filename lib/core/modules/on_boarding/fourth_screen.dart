import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/modules/widgets/app_button_on_boarding.dart';
import 'package:movies_app/core/modules/widgets/bottom_sheet.dart';
import '../../../main.dart';
import '../../configuration/gen/assets.gen.dart';
import '../../configuration/routes/app_routes_name.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(children: [
        Assets.images.doctorStrange.image(fit: BoxFit.cover),
        Column(children: [
          Spacer(),
          BottomSheets(
            title: "Rate, Review, and Learn",
            description: "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
            height: 340,
          )
        ],),
        Column(
          spacing: 12,
          children: [
            Spacer(),

            GestureDetector(onTap:(){
              navigatorKey.currentState?.pushNamed(AppRoutesName.fifthScreen);
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
