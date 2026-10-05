import 'package:flutter/material.dart';
import '../../../core/configuration/gen/assets.gen.dart';
import '../../configuration/theme/app_colors.dart';
import '../widgets/app_button_widget.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/arrow_back_widget.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView ({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(

      appBar: AppBar(
        title: Text("Forget Password",style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 18,
          color: AppColors.buttonView,
        ),),
        leading: ArrowBackWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 24,
            children: [
              SizedBox(height: 30,),
              Assets.images.forgetPassword.image(),

              AppTextFormField(
                  hintText: "Email",
                  controller: _emailController,
                  prefixIcon: Assets.icons.emailIcon.svg(),
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your email";
                    }
                    final emailRegex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  }),
              AppButtonWidget(title: "Verify Email")
            ],
          ),
        ),
      ),
    );
  }
}
