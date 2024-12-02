import 'dart:io'; // Required for platform checks
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class AppState extends ChangeNotifier {
  String quote = "Loading quote...";
  String author = "Loading...";

  // Theme management
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Habits management
  List<Map<String, dynamic>> habits = [
    {'title': 'Exercise for 30 mins', 'isChecked': false},
    {'title': 'Fetch dynamic background images', 'isChecked': false},
    {'title': 'Change AppBar to add Stories tab', 'isChecked': false},
    {'title': 'Make this list dynamic', 'isChecked': false},
    {'title': 'Add user notifications', 'isChecked': false},
  ];

  void addHabit(String habitTitle) {
    habits.add({'title': habitTitle, 'isChecked': false});
    notifyListeners();
  }

  void removeHabit(int index) {
    habits.removeAt(index);
    notifyListeners();
  }

  void toggleHabitCheck(int index, bool isChecked) {
    habits[index]['isChecked'] = isChecked;
    notifyListeners();
  }

  void updateQuote(String newQuote, String newAuthor) {
    quote = newQuote;
    author = newAuthor;
    notifyListeners();
  }

  // Notifications management
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool notificationsEnabled = false;

  AppState() {
    _initNotifications();
    tz.initializeTimeZones(); // Initialize the time zones
    _requestPermissionsOnLaunch(); // Request permissions when the app starts
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    notifyListeners();
  }

  // Request permissions when the app starts (for Android 12+)
  Future<void> _requestPermissionsOnLaunch() async {
    if (Platform.isAndroid) {
      // Request notification permission on Android 12+
      var status = await Permission.notification.status;
      if (status.isDenied) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> scheduleNotification(String title, String body, DateTime scheduledTime) async {
    // Check if the app has permission to schedule exact alarms
    if (await Permission.notification.isGranted) {
      tz.TZDateTime tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

      // Schedule notification with the correct parameters
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tzDateTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'habit_reminder_channel',
            'Habit Reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exact, // Exact scheduling
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else {
      // Handle case where permission is not granted (optional)
      print('Permission to schedule notifications is not granted');
    }
  }
}

