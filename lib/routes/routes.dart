import 'package:flutter/material.dart';

import '../screens/nav_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/http_screen.dart';
import '../screens/http_joke_screen.dart';
import '../screens/listview_screen.dart';
import '../screens/chart_screen.dart';
import '../screens/shared_preferences_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  static const initialRoute = '/';
  static const homeRoute = '/home';
  static const profileRoute = '/profile';
  static const httpRoute = '/http';
  static const httpJokeRoute = '/http_joke';
  static const listviewRoute = '/listview';
  static const chartRoute = '/chart';
  static const sharedPreferencesRoute = '/shared_preferences';
  static const loginRoute = '/login';

  static Map<String, Widget Function(BuildContext)> routes = {
    initialRoute: (context) => const NavScreen(),
    homeRoute: (context) => const HomeScreen(),
    profileRoute: (context) => ProfileScreen(),
    httpRoute: (context) => const HTTPScreen(),
    httpJokeRoute: (context) => const HTTPJokeScreen(),
    listviewRoute: (context) => const PostListScreen(),
    chartRoute: (context) => const BitcoinPriceChart(),
    sharedPreferencesRoute: (context) => const SharedPreferencesScreen(),
    loginRoute: (context) => const LoginScreen(),
  };
}
