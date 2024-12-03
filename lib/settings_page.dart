import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'database_helper.dart'; // Assuming this helper class has a method to store feedback

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    // Function to trigger the test notification
    void sendTestNotification() {
      FlutterLocalNotificationsPlugin().show(
        0,
        "Test Notification",
        "This is a test notification",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'test_channel',
            'Test Notifications',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    }

    // Function to show the feedback form
    void showFeedbackForm(BuildContext context) {
      final feedbackController = TextEditingController(); // Controller for the feedback input

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What could be improved with the app experience?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write your feedback here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          String feedback = feedbackController.text.trim();
                          if (feedback.isNotEmpty) {
                            // Save the feedback to the database
                            await DatabaseHelper.insertFeedback(feedback);
                          }
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Dark Mode Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: appState.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    appState.toggleTheme();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Notifications Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Notifications'),
                Switch(
                  value: appState.notificationsEnabled,
                  onChanged: (value) {
                    appState.toggleNotifications(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Test Notification Button
            Center(
              child: ElevatedButton(
                onPressed: sendTestNotification,  // Trigger the notification when pressed
                child: const Text('Send Test Notification'),
              ),
            ),
            const SizedBox(height: 20),
            // Feedback Button
            Center(
              child: ElevatedButton(
                onPressed: () => showFeedbackForm(context), // Show the feedback form when pressed
                child: const Text('Provide Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

