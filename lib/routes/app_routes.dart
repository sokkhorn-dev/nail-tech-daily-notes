import 'package:flutter/material.dart';
import '../features/auth/screens/splash/splash_screen.dart';
import '../features/auth/screens/login/login_screen.dart';
import '../features/auth/screens/login/register_screen.dart';

// Main Screens
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/main_screen.dart';
import '../features/profile/screens/edit/edit_profile_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/settings/about_app/about_app_screen.dart';
import '../features/profile/screens/settings/change_password/change_password_screen.dart';
import '../features/profile/screens/settings/language/language_screen.dart';
import '../features/profile/screens/settings/settings_screen.dart';
import '../features/reports/screens/reports_screen.dart';
import '../features/services/screens/add_client/add_client_screen.dart';
import '../features/services/screens/add_service/add_service_screen.dart';
import '../features/services/screens/services_screen.dart';


class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String notes = '/notes';
  static const String addNote = '/add-note';

  // services screen
  static const String services = '/services';
  static const String addService = '/add-service';


  static const String reports = '/reports';
  static const String profile = '/profile';
  static const String addClient = '/addClient';

  // 🔥 NEW ROUTES
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String language = '/language';
  static const String about = '/about';

  // Route Map
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),

    // services screen
    services: (context) => const ServicesScreen(),
    addService: (context) => const AddServiceScreen(),

    reports: (context) => const ReportsScreen(),
    profile: (context) => const ProfileScreen(),
    addClient: (context) => const AddClientScreen(),

    // settings SCREENS
    settings: (context) => const SettingsScreen(),
    editProfile: (context) => const EditProfileScreen(),
    changePassword: (context) => const ChangePasswordScreen(),
    language: (context) => const LanguageScreen(),
    about: (context) => const AboutAppScreen(),
  };
}