import 'package:flutter/material.dart';
import 'quote_fetch.dart';  

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
      debugShowCheckedModeBanner: false,
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
  final List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    var quoteData = await QuotesFetch.fetchQuote();
    setState(() {
      quote = quoteData['quote']!;
      author = quoteData['author']!;
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String taskText = '';
        return AlertDialog(
          title: const Text('Add a Task'),
          content: TextField(
            onChanged: (value) {
              taskText = value;
            },
            decoration: const InputDecoration(hintText: "Enter your task"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (taskText.isNotEmpty) {
                  setState(() {
                    _tasks.add({'title': taskText, 'completed': false});
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BoostBuddy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchQuote,
          ),
        ],
      ),
      body: Column(
        children: [
          // Quote Section
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/mtnshadow.jpg',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"$quote"',
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
                          '- $author',
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
          // Dynamic To-Do List
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TO-DO LIST ETC',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return ListTile(
                          leading: Checkbox(
                            value: task['completed'],
                            onChanged: (bool? value) {
                              setState(() {
                                _tasks[index]['completed'] = value!;
                              });
                            },
                          ),
                          title: Text(
                            task['title'],
                            style: TextStyle(
                              decoration: task['completed']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _tasks.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
