import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import '../../../main.dart';
import '../../configuration/gen/assets.gen.dart';
import '../../configuration/routes/app_routes_name.dart';
import '../../utils/firebase_auth_service.dart';
import '../widgets/app_button_widget.dart';
import '../widgets/app_text_form_field.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Assets.images.moviesLogo.image(height: 180, width: 180,),
                ),

                AppTextFormField(
                  hintText: "Email",
                  prefixIcon: Assets.icons.emailIcon.svg(),
                  controller: _emailController,
                  validator: (value){
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your email";
                    }
                    return null;
                  },),



                SizedBox(height: 16,),

                AppTextFormField(
                  hintText: "Password",
                  prefixIcon: Assets.icons.passwordIcon.svg(),
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value)
                  {
                    if (value == null || value.isEmpty)
                    {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                GestureDetector(onTap: (){
                  navigatorKey.currentState?.pushNamed(AppRoutesName.forgetPassword);
                },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 200.0,top: 4),
                    child: Text("Forget Password ?",

                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonView,
                          //decoration: TextDecoration.underline,
                          decorationColor: theme.primaryColor,
                          //decorationThickness: 2
                         ) ,),
                  ),
                ),


                SizedBox(height: 45,),
                AppButtonWidget(
                  title: "Login",
                  onTap: (){
                    if (_formKey.currentState!.validate())
                    {
                      EasyLoading.show();
                      FirebaseAuthService.signInWithAccount(_emailController.text, _passwordController.text)
                          .then((value){
                        EasyLoading.dismiss();
                        if (value) {
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutesName.layout, (route)=>false);
                        }
                      });
                    }

                  },),
                SizedBox(height: 45,),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(text: "Don’t Have Account ? ",style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textMain)),

                          WidgetSpan( child:GestureDetector(
                              onTap: (){
                                navigatorKey.currentState?.pushNamed(AppRoutesName.register);
                              },child: Text( "Create One",style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.buttonView,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ))


                          ))
                        ]

                    )),
                SizedBox(height: 35,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(endIndent: 20,indent: 20,color: AppColors.buttonView,)),
                    Text("OR",style: theme.textTheme.titleMedium?.copyWith(color: AppColors.buttonView),),
                    Expanded(child: Divider(endIndent: 20,indent: 20,color: AppColors.buttonView,))

                  ],),

                SizedBox(height: 35,),
                AppButtonWidget(
                    title: "Login with Google",
                    titleColor: AppColors.textFormFill,
                    preIcon: Assets.icons.googleIcon.svg()),
                
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
                  ],),
                )





              ],),
          ),
        ),
      ),
    );
  }
}
