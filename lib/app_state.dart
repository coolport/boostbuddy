import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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

  Future<void> scheduleNotification(String title, String body, DateTime scheduledTime) async {
    // Convert DateTime to TZDateTime
    tz.TZDateTime tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

    // Schedule notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tzDateTime, // Use TZDateTime instead of DateTime
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_reminder_channel',
          'Habit Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact, // Specify the schedule mode
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

