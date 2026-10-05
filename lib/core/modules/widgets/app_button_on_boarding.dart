import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';

class AppButtonOnBoarding extends StatelessWidget {
  final Color buttonColor;
  final String buttonText ;
  final Color textColor;

    const AppButtonOnBoarding({super.key,this.buttonColor = AppColors.buttonView ,required this.buttonText, this.textColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: buttonColor,
          border: Border.all(color: AppColors.buttonView)
        ),
        child: Center(child: Text(buttonText,style: theme.textTheme.titleLarge?.copyWith(fontSize: 18,color: textColor),)),
      ),
    );
  }
}
