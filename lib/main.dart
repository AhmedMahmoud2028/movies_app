import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. استيراد حزمة flutter_bloc
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/core/configuration/routes/app_routes_manager.dart';
import 'package:movies_app/core/configuration/routes/app_routes_name.dart';
import 'package:movies_app/core/configuration/theme/app_theme_manager.dart';
import 'package:movies_app/core/modules/layout/home/movie_cubit/movie_cubit.dart'; // 2. استيراد الـ MovieCubit
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. تغليف MaterialApp بـ MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCubit>(
          create: (context) => MovieCubit(),
        ),
        // يمكنك إضافة أي Cubit/Bloc آخر مستقبلاً هنا بكل سهولة
      ],
      child: MaterialApp(
        theme: AppThemeManager.appTheme(),
        initialRoute: AppRoutesName.initial,
        onGenerateRoute: AppRoutesManager.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
      ),
    );
  }
}