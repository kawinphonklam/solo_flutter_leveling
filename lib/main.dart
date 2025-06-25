import 'package:flutter/material.dart';
import 'screens/nav_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/http_screen.dart';
import 'screens/http_joke_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const NavScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/http': (context) => const HTTPScreen(),
        '/http_joke': (context) => const HTTPJokeScreen(),
      },
    );
  }
}
