import 'package:flutter/material.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample stories data
    final stories = [
      {
        'title': 'Overcoming Challenges',
        'content': 'This is a story about overcoming challenges and achieving success despite all odds.'
      },
      {
        'title': 'The Power of Kindness',
        'content': 'Kindness can change the world, one small act at a time. This story illustrates how.'
      },
      {
        'title': 'Never Giving Up',
        'content': 'A tale of perseverance, showing how resilience can lead to amazing results.'
      },
      {
        'title': 'Chasing Dreams',
        'content': 'Follow your passion and see how pursuing dreams can lead to fulfillment and happiness.'
      },
      {
        'title': 'Helping Others',
        'content': 'A story about how lending a helping hand can bring joy and meaning to life.'
      },
      {
        'title': 'Finding Hope',
        'content': 'Even in the darkest times, hope can be found. This story is about finding light in the darkness.'
      },
      {
        'title': 'Overcoming Fear',
        'content': 'This story demonstrates how facing fears head-on can lead to personal growth and freedom.'
      },
      {
        'title': 'The Strength of Community',
        'content': 'A heartwarming story of people coming together to make a difference.'
      },
      {
        'title': 'Achieving the Impossible',
        'content': 'This inspiring tale shows how determination can turn the impossible into reality.'
      },
      {
        'title': 'The Journey of Self-Discovery',
        'content': 'This story highlights the importance of understanding oneself to find true happiness.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspiring Stories'),
      ),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(stories[index]['title']!),
              subtitle: Text(
                stories[index]['content']!.length > 50
                    ? '${stories[index]['content']!.substring(0, 50)}...' // Show snippet
                    : stories[index]['content']!,
              ),
              onTap: () {
                // Navigate to detailed story view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryDetailPage(
                      title: stories[index]['title']!,
                      content: stories[index]['content']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Detailed Story Page
class StoryDetailPage extends StatelessWidget {
  final String title;
  final String content;

  const StoryDetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
