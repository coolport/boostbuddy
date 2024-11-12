// main.dart

import 'package:flutter/material.dart';
import 'quote_fetch.dart';  // Import the QuoteService class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoostBuddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MotivatorHomePage(),
    );
  }
}

class MotivatorHomePage extends StatefulWidget {
  const MotivatorHomePage({super.key});

  @override
  _MotivatorHomePageState createState() => _MotivatorHomePageState();
}

class _MotivatorHomePageState extends State<MotivatorHomePage> {
  String quote = "Loading quote...";
  String author = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    // Use the QuoteService class to fetch the quote
    var quoteData = await QuoteService.fetchQuote();
    
    setState(() {
      quote = quoteData['quote']!;
      author = quoteData['author']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BoostBuddy"),
        actions: [
          // Add a reload button in the app bar to trigger quote reloading
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchQuote, // Trigger quote reloading
          ),
        ],
      ),
      body: Column(
        children: [
          // Quote Section with background image
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.asset(
                  'assets/mtnshadow.jpg', // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
                // Quote overlay
                Container(
                  color: Colors.black.withOpacity(0.4), // Dark overlay for readability
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"$quote"', // Display the fetched quote
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '- $author', // Display the author of the quote
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Habit Tracker / To-Do List Section
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Habit Tracker / To-Do List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Sample list of habits/tasks
                  //for examples only, implementation will not be like this obv
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('Exercise for 30 mins'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('fetch dynamic bg images with Image.network()'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('change appbar to add stories tab'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('make this list dynamic'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('user notifications, styling, etcetcetc'),
                        )
                        // Add more ListTiles for tasks
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
