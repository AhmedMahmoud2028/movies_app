import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';



class AppTextFormField extends StatefulWidget {

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final  bool isPassword;
  final int? maxLines;

  const AppTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1});

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {

  bool isPasswordInvisible = true;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? isPasswordInvisible : false,
      /// obscuringCharacter: "#",  for change shape of obscureText
      cursorColor: theme.primaryColor,
      maxLines: widget.maxLines,
      /// maxLength: 100,  for write limited words just 100 word
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          fillColor: AppColors.textFormFill,
          filled: true,
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textMain),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: AppColors.primary)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: AppColors.primary)
          ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: AppColors.primary)
        ),

          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: widget.prefixIcon,
          ),
          suffixIconConstraints: BoxConstraints(minHeight: 24,minWidth: 24),///*****
          suffixIcon: widget.isPassword ?
              Bounceable(onTap:(){
                setState(() {
                  isPasswordInvisible = !isPasswordInvisible;
                });
              },child: Padding(padding: const EdgeInsets.all(12),
                child: isPasswordInvisible
                         ? Icon(Icons.visibility_off_outlined,color: AppColors.textMain,)
                         : Icon(Icons.remove_red_eye_outlined,color: AppColors.textMain),))
                : widget.suffixIcon,
          ),
      );
  }
}
