import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'routes/routes.dart';

// Secure storage instance (used directly in screens or via services)
final storage = FlutterSecureStorage();

// Riverpod provider for SharedPreferences (injected globally)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // will be overridden in main()
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = await storage.read(key: 'token');
  final hasName = prefs.getString('name')?.isNotEmpty ?? false;

  // Determine where to start
  final initialRoute = (token != null && hasName)
      ? AppRoutes.initialRoute
      : AppRoutes.loginRoute;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
