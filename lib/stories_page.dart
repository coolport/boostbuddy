import 'package:flutter/material.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> stories = [
      "Story 1: Overcoming Adversity",
      "Story 2: Rising Above Challenges",
      "Story 3: Inspiring Journey of Success",
      "Story 4: The Power of Persistence",
      "Story 5: Dreams Turned into Reality",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inspiring Stories"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                stories[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
