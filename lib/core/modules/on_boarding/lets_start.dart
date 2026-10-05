import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/modules/widgets/app_button_on_boarding.dart';
import 'package:movies_app/main.dart';

import '../../configuration/gen/assets.gen.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: Stack(
            children:[
              Assets.images.moviesPosters.image(fit: BoxFit.cover),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 16,
                children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text("     Find Your Next Favorite Movie Here",style: theme.textTheme.headlineMedium,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33.0),
                  child: Text("Get access to a huge library of movies to suit all tastes. You will surely like it.",
                  style: theme.textTheme.bodyLarge),),

                GestureDetector(onTap:(){
                navigatorKey.currentState?.pushNamed(AppRoutesName.firstScreen);
                },child: AppButtonOnBoarding(buttonText: "Explore Now")),

                SizedBox(height: 45,)
              ],)
          ]),



      );
  }
}
