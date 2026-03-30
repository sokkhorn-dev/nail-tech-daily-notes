import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nail_tech_daily_notes/routes/app_routes.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,

      // Routes
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,

      // Hide keyboard when tap outside
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child!,
        );
      },
    );
  }
}