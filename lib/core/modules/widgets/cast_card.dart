import 'package:flutter/material.dart';
import '../../configuration/theme/app_colors.dart';

class CastCard extends StatelessWidget {
  final String image;
  final String name;
  final String character;
  const CastCard({super.key, required this.image, required this.name, required this.character});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.textFormFill,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          spacing: 10,
          children: [
          Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover)
              ),),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Name : $name",style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textMain),),
            Text("Character : $character",style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textMain),)
          ],)
        ],),
      ),
    );
  }
}
