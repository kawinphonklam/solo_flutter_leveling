import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/providers/provider.dart';
import 'package:flutter_app/screens/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildContainer('Container 1'),
              _buildContainer('Container 2'),
              _buildContainer('Container 3'),
              _buildContainer('Container 4'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Text('Remember Email'),
              ]),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Email Entered'),
                          content: Text(
                            'You entered: "${_emailController.text}"',
                          ),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _emailController.clear();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Wrong email format'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              ),
              TextField(
                onChanged: (value) =>
                    ref.read(nameProvider.notifier).state = value,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()),
                  );
                },
                child: Text('Go to Profile screen'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text('pushNamed: /profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String label) {
    return Container(
      width: 190,
      height: 100,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
