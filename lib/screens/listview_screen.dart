import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_detail_screen.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<dynamic> posts = [];
  bool isLoading = true;

  Future<void> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://www.arbeitnow.com/api/job-board-api'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      setState(() {
        posts = jsonBody['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load posts ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job seek in UK')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                int id = index + 1;
                return ListTile(
                  leading: Text(id.toString()),
                  title: Text(post['title'] ?? 'No title'),
                  subtitle: Text(
                    post['company_name'] ?? 'No description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
