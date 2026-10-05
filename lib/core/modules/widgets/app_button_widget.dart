import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../../configuration/theme/app_colors.dart';

class AppButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final Widget? preIcon;
  final Widget? suffixIcon;

  final double padding;

  const AppButtonWidget({
    super.key,
    this.onTap,
    required this.title,
    this.backgroundColor = AppColors.buttonView,
    this.titleColor = AppColors.primary,
    this.preIcon,
    this.suffixIcon,
    this.borderColor,
    this.padding = 0});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Bounceable(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,

        padding: EdgeInsets.symmetric(vertical: 10,horizontal: padding),
        //margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),

        ),

        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?preIcon,         /// or use this -> if(icon != null) icon!,

            Text(title,
              style: theme.textTheme.titleLarge?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),),

            ?suffixIcon
          ],
        ),
      ),
    );
  }
}
