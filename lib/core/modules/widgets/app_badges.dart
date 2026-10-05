import 'package:flutter/material.dart';
import '../../configuration/theme/app_colors.dart';

class AppBadges extends StatelessWidget {
  final num number;
  final Widget icon;


  const AppBadges({super.key,required this.icon,required this.number});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.textFormFill
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: Row(
          spacing: 8,
          children: [
            icon ,
            Text(number.toString(),style: theme.textTheme.headlineSmall,),
          ],),
      ),
    );
  }
}
