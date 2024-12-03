import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  _StoriesPageState createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  FlutterTts flutterTts = FlutterTts();

  // Sample list of stories
  final List<Map<String, String>> stories = [
    {
      'title': 'Oprah Winfrey - Rise to Fame',
      'content': 'Oprah was told she wasn’t fit for television early in her career. She faced numerous setbacks, including being fired from her first TV job. Despite the odds, she built a media empire and became a global symbol of empowerment, proving that resilience can turn challenges into triumphs.',
      'image': 'assets/oprah.jpg',
    },
    {
      'title': 'The Small Seed',
      'content': 'A tiny seed, buried deep in the soil, dreamed of becoming a tree. Days turned into weeks, and slowly, it grew, breaking through the earth. It stood tall as a mighty oak, proud of its journey from a small seed to something grand.',
      'image': 'assets/seed.jpeg',
    },
    {
      'title': 'J.K. Rowlings Rejection Letters',
      'content': 'Before Harry Potter became a global phenomenon, J.K. Rowling was rejected by 12 publishers. She was a single mother living on welfare, and her manuscript was nearly thrown out. Today, she’s one of the world’s most successful authors, proving that rejection is just a stepping stone to success.Before Harry Potter became a global phenomenon, J.K. Rowling was rejected by 12 publishers. She was a single mother living on welfare, and her manuscript was nearly thrown out. Today, she’s one of the world’s most successful authors, proving that rejection is just a stepping stone to success.',
      'image': 'assets/jk.jpg',
    },
    {
      'title': 'On The Music That Is Silence',
      'content': 'On a rainy afternoon, Olivia sat by the window, watching the drops race down the glass. There was no sound, but in the silence, she could hear music in her heart. The rhythm of the rain, the wind’s gentle whisper, and the distant hum of life—she realized that sometimes, the quietest moments are the most meaningful.',
      'image': 'assets/music.jpg',
    },
    {
      'title': 'The Marathoner',
      'content': 'After breaking both legs in a car accident, he crossed the finish line of his first marathon two years later—crawling.',
      'image': 'assets/marathon.jpg',
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
      appBar: AppBar(title: const Text('Stories')),
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
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
                        color: Theme.of(context).textTheme.bodyLarge?.color,  // Updated to bodyText2
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
                        color: Theme.of(context).textTheme.bodyLarge?.color,  // Updated to bodyText2
                      ),
                    ),
                  ),
                  // Text-to-Speech Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _speakStory(story['content']!),
                      child: const Text('Read Aloud'),
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

