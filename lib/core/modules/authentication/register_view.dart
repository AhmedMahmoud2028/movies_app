import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import '../../../core/configuration/gen/assets.gen.dart';
import '../../../core/configuration/routes/app_routes_name.dart';
import '../../../main.dart';
import '../../service/snack_bar_service.dart';
import '../../utils/firebase_auth_service.dart';
import '../widgets/app_button_widget.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/arrow_back_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumber = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(

      appBar: AppBar(
          title: Text("Register",style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              color: AppColors.buttonView),),

          leading: ArrowBackWidget()

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 48,),



                AppTextFormField(
                  hintText: "Name",
                  controller: _nameController,
                  prefixIcon: Assets.icons.nameIcon.svg(),
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your name";
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
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
                SizedBox(height: 16,),
                AppTextFormField(
                  hintText: "Password",
                  controller: _passwordController,
                  prefixIcon: Assets.icons.passwordIcon.svg(),
                  isPassword: true,
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your password";
                    }
                    final strongPasswordRegex = RegExp(
                      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?])[A-Za-z\d!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{8,}$',
                    );
                    if (!strongPasswordRegex.hasMatch(value)) {
                      return 'Please enter a strong password';
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
                AppTextFormField(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  prefixIcon: Assets.icons.passwordIcon.svg(),
                  isPassword: true,
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your password";
                    }
                    if (value != _passwordController.text)
                    {
                      return "Password don't match";
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
                AppTextFormField(
                  hintText: "Phone Number",
                  controller: _phoneNumber,
                  prefixIcon: Assets.icons.phoneIcon.svg(),
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your Phone Number";
                    }
                    return null;
                  },),
                SizedBox(height: 52,),
                AppButtonWidget(
                  title: "Create Account",
                  onTap: (){
                    if (_formKey.currentState!.validate())
                    {
                      EasyLoading.show();
                      FirebaseAuthService.createAccount(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                          name: _nameController.text.trim(),
                          phone: _phoneNumber.text.trim())
                          .then((value){
                        EasyLoading.dismiss();
                        if (value) {
                          SnackBarService.showSuccessMessage("Account had been created Successfully");
                          navigatorKey.currentState!.pop();
                        }
                      });
                    }
                  },),
                SizedBox(height: 24,),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(text: "Already have Account? ",style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textMain)),
                          WidgetSpan( child:GestureDetector(
                              onTap: (){
                                navigatorKey.currentState?.pushNamed(AppRoutesName.logIn);
                              },child: Text( "Login",style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.buttonView,
                            fontWeight: FontWeight.w600,
                            //decoration: TextDecoration.underline,
                            //decorationThickness: 2,
                          ))
                          )
                          )
                        ])
                ),
                SizedBox(height: 35,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.buttonView)
                  ),
                  child: Row(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Assets.icons.usaIcon.svg(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Assets.icons.egIcon.svg(),
                      )
                    ],),)


              ],),
          ),
        ),
      ),
    );
  }
}
