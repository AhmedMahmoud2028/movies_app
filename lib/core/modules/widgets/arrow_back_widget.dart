import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../../../main.dart';
import '../../configuration/gen/assets.gen.dart';
import '../../configuration/theme/app_colors.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(onTap: (){
      navigatorKey.currentState?.pop();
    },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.buttonView,
            )
        ),
        child: Assets.icons.arrowback.svg(
            colorFilter: ColorFilter.mode(
                AppColors.buttonView,
                BlendMode.srcIn)

        ),

      ),
    );
  }
}
