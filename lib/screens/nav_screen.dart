import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'http_screen.dart';
import 'http_joke_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    HTTPScreen(),
    HTTPJokeScreen(),
  ];

  final List<String> _titles = ['BASIC WIDGETS', 'Profile', 'HTTP response code image', 'HTTP Joke'];

  void _onSelectDrawerItem(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('BASIC WIDGETS'),
              selected: _selectedIndex == 0,
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('Profile'),
              selected: _selectedIndex == 1,
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('HTTP response code image'),
              selected: _selectedIndex == 2,
              onTap: () => _onSelectDrawerItem(2),
            ),
            ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('HTTP Joke'),
              selected: _selectedIndex == 3,
              onTap: () => _onSelectDrawerItem(3),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
