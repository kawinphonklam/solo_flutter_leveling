import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  State<SharedPreferencesScreen> createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _savedName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('name') ?? '';
    });
  }

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    setState(() {
      _savedName = _nameController.text;
    });
  }

  Future<void> _clearName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    setState(() {
      _savedName = '';
      _nameController.clear();
    });
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveName,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: _clearName,
              child: const Text('Clear'),
            ),
            const SizedBox(height: 20),
            Text(
              'Saved Name: $_savedName',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('pushNamed: /home'),
            ),
          ],
        ),
      ),
    );
  }
}
