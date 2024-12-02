import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoriesPage extends StatefulWidget {
  @override
  _StoriesPageState createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  FlutterTts flutterTts = FlutterTts();

  // Sample list of stories
  final List<Map<String, String>> stories = [
    {
      'title': 'The Brave Little Lion',
      'content': 'OOnce upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...Once upon a time in the jungle, there was a small lion who...nce upon a time in the jungle, there was a small lion who...',
      'image': 'https://example.com/lion_image.jpg',
    },
    {
      'title': 'The Curious Rabbit',
      'content': 'In a quiet forest, a rabbit loved to explore. One day...',
      'image': 'https://example.com/rabbit_image.jpg',
    },
    {
      'title': 'The Kind Elephant',
      'content': 'An elephant known for her kindness helped all the animals in the jungle...',
      'image': 'https://example.com/elephant_image.jpg',
    },
  ];

  // Method to trigger text-to-speech
  Future<void> _speakStory(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stories')),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      story['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      story['title']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Content (Story Text)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      story['content']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Text-to-Speech Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _speakStory(story['content']!),
                      child: Text('Read Aloud'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

