import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPJokeScreen extends StatefulWidget {
  const HTTPJokeScreen({super.key});

  @override
  State<HTTPJokeScreen> createState() => _HTTPJokeScreenState();
}

class _HTTPJokeScreenState extends State<HTTPJokeScreen> {
  String title = 'Loading...';
  String joke = '';
  String selectedValue = 'Any';
  Map<String, bool> flags = {};

  final List<String> dropdownItems = [
    'Any',
    'Programming',
    'Misc',
    'Dark',
    'Pun',
    'Spooky',
    'Christmas',
  ];

  Future<void> fetchData() async {
    final url = 'https://v2.jokeapi.dev/joke/$selectedValue';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        title = data['category'] ?? 'No Category';
        joke = data['type'] == 'single'
            ? data['joke']
            : '${data['setup']}\n\n${data['delivery']}';
        flags = Map<String, bool>.from(data['flags'] ?? {});
      });
    } else {
      setState(() {
        title = 'Error';
        joke = 'Failed to load joke: ${response.statusCode}';
        flags = {};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose a category:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                },
                items: dropdownItems
                    .map((value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchData,
                child: const Text('Load Joke'),
              ),
              const SizedBox(height: 20),
              Text(
                joke,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (flags.isNotEmpty) ...[
                Text('Flags:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ...flags.entries.map(
                  (data) => Text(
                    '${data.key}: ${data.value}',
                    style: TextStyle(
                      fontSize: 14,
                      color: data.value ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
