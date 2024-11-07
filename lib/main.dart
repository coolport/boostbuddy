import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customized Layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BoostBuddy!!!!!!!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Section with background color and text
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            child: const Center(
              child: Text(
                'label this, add color and image',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Spacer to separate sections and allocate space
          // visualize space for habits box later
          const Spacer(), const Spacer(),
          // Typeable box
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type something here...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

