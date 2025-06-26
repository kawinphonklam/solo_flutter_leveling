import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostDetailScreen({super.key, required this.post});

  @override
  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(post['created_at'] * 1000);
    String dateFormatted = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return Scaffold(
      appBar: AppBar(title: const Text('Post Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${post['title']}'),
            const SizedBox(height: 10),
            Text('Company Name: ${post['company_name']}'),
            const SizedBox(height: 10),
            const Text('Description:'),
            Html(data: post['description']),
            const SizedBox(height: 10),
            Text('Tags: ${post['tags']}'),
            const SizedBox(height: 10),
            Text('Job Types: ${post['job_types']}'),
            const SizedBox(height: 10),
            Text('Location: ${post['location']}'),
            const SizedBox(height: 10),
            Text('Created At: $dateFormatted'),
          ],
        ),
      ),
    );
  }
}
