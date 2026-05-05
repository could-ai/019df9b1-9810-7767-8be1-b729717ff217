import 'package:flutter/material.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> _posts = [
    Post(
      id: '1',
      authorName: 'John Doe',
      content: 'Welcome to ARCHIVE ACADEMY!',
      likes: 10,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Post(
      id: '2',
      authorName: 'Jane Smith',
      content: 'Learning Flutter is fun.',
      likes: 5,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  void _showPostModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final textController = TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Create Post', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    setState(() {
                      _posts.insert(
                        0,
                        Post(
                          id: DateTime.now().toString(),
                          authorName: 'Current User',
                          content: textController.text,
                          likes: 0,
                          timestamp: DateTime.now(),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Post'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ARCHIVE ACADEMY'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(post.content),
                  const SizedBox(height: 8),
                  Text(
                    '${post.likes} Likes • ${post.timestamp.hour}:${post.timestamp.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
