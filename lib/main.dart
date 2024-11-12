import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MotivatorHomePage(),
    );
  }
}

class MotivatorHomePage extends StatelessWidget {
  const MotivatorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          '"Your daily motivational quote here!"', // Fetch and display quote text from API
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '- Author', // Fetch and display author from API
                          style: TextStyle(
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
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('Exercise for 30 mins'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('Read 10 pages of a book'),
                        ),
                        ListTile(
                          leading: Checkbox(value: false, onChanged: (_) {}),
                          title: const Text('Meditate for 10 mins'),
                        ),
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
