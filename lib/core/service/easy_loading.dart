import 'package:flutter/material.dart';


import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../configuration/theme/app_colors.dart';

void configurationLoading ()
{
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45
    ..radius = 12
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColors.primary
    ..textColor = AppColors.primary
    ..userInteractions = false
    ..dismissOnTap = false;


}