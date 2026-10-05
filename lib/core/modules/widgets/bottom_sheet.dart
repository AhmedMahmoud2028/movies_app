import 'package:flutter/material.dart';

import '../../configuration/theme/app_colors.dart';
class BottomSheets extends StatelessWidget {
  final String title;
  final String description;
  final double? height;


  const BottomSheets({super.key, required this.title, this.description = "", required this.height,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
          color: AppColors.primary
      ),child: Column(
      spacing: 12,
      children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text(title,style: theme.textTheme.headlineSmall,),
       ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(description,style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textMain),),
      ),

    ],),
    );
  }
}
