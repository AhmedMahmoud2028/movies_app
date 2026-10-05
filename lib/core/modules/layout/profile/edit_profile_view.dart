import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/modules/widgets/app_button_widget.dart';
import 'package:movies_app/core/modules/widgets/app_text_form_field.dart';
import 'package:movies_app/main.dart';

import '../../../configuration/gen/assets.gen.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap:(){
            navigatorKey.currentState?.pop();
          },child: Icon(Icons.arrow_back,color: AppColors.buttonView,)),
          title: Text("Pick Avatar",style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.buttonView),),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120.0,vertical: 40),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: Assets.images.avatar1.provider(),
                ),),

              AppTextFormField(hintText: "Ahmed Mahmoud",prefixIcon: Assets.icons.profileIcon.svg(),),
              SizedBox(height: 20,),
              AppTextFormField(hintText: "01024775351",prefixIcon: Assets.icons.phoneIcon.svg(),),
              SizedBox(height: 20,),
              Text("Reset Password",
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.start,),

              Spacer(),

              AppButtonWidget(
                title: "Delete Account",
                backgroundColor: AppColors.redButton,
                titleColor: AppColors.textMain,),
              SizedBox(height: 20,),
              AppButtonWidget(title: "Update Data"),
              SizedBox(height: 20,)
            ],),
        ),
      ),
    );
  }
}
