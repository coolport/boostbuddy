import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'quote_fetch.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MotivatorHomePage extends StatelessWidget {
  const MotivatorHomePage({super.key});

  Future<void> _fetchNewQuote(BuildContext context) async {
    var quoteData = await QuotesFetch.fetchQuote();
    context.read<AppState>().updateQuote(quoteData['quote']!, quoteData['author']!);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("BoostBuddy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _fetchNewQuote(context),
          ),
        ],
      ),
      body: Column(
        children: [
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
                          '"${appState.quote}"',
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
                          '- ${appState.author}',
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
          Expanded(
            flex: 3,
            child: HabitTracker(),
          ),
        ],
      ),
    );
  }
}

class HabitTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: appState.habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(appState.habits[index]['title']),
                  leading: const Icon(Icons.notifications),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => appState.removeHabit(index),
                  ),
                  onTap: () async {
                    DateTime? selectedTime = await _pickTime(context);
                    if (selectedTime != null) {
                      appState.scheduleNotification(
                        appState.habits[index]['title'],
                        "Reminder: ${appState.habits[index]['title']}",
                        selectedTime,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Notification scheduled for "${appState.habits[index]['title']}" at ${DateFormat('hh:mm a').format(selectedTime)}',
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              final textController = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add a new habit'),
                    content: TextField(controller: textController),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AppState>().addHabit(textController.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _pickTime(BuildContext context) async {
    final now = DateTime.now();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (time != null) {
      return DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }
    return null;
  }
}
