import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPScreen extends StatefulWidget {
  const HTTPScreen({super.key});

  @override
  State<HTTPScreen> createState() => _HTTPScreenState();
}

class _HTTPScreenState extends State<HTTPScreen> {
  String title = 'Loading...';
  final TextEditingController imageController = TextEditingController();
  String imageUrl = 'https://http.cat/200';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Optional: your original response processing
      // final data = json.decode(response.body);
      setState(() {
        title = 'Image loaded successfully';
      });
    } else {
      setState(() {
        title = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: screenWidth * 0.8,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Image not found'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Enter response code'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final code = imageController.text.trim();
                if (code.isNotEmpty) {
                  setState(() {
                    imageUrl = 'https://http.cat/$code';
                  });
                  fetchData();
                }
              },
              child: const Text('Load Image'),
            ),
          ],
        ),
      ),
    );
  }
}
