import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'database_helper.dart'; // Assuming you have this helper class to manage database operations

class AppState extends ChangeNotifier {
  String quote = "Loading quote...";
  String author = "Loading...";

  // Theme management
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  // Habits management
  List<Map<String, dynamic>> habits = [
    {'title': 'Exercise for 30 mins', 'isChecked': false},
    {'title': 'Fetch dynamic background images', 'isChecked': false},
    {'title': 'Change AppBar to add Stories tab', 'isChecked': false},
    {'title': 'Make this list dynamic', 'isChecked': false},
    {'title': 'Add user notifications', 'isChecked': false},
  ];

  bool notificationsEnabled = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AppState() {
    _initNotifications();
    tz.initializeTimeZones(); // Initialize the time zones
    _loadAppState();
  }

  // Load app settings from the database (including dark mode and habits)
  Future<void> _loadAppState() async {
    // Load dark mode setting
    String? darkMode = await DatabaseHelper.getSetting('darkMode');
    if (darkMode != null && darkMode == 'true') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    // Load habits from the database
    habits = await DatabaseHelper.getHabits();

    // Load notifications setting
    String? notifications = await DatabaseHelper.getSetting('notificationsEnabled');
    if (notifications != null && notifications == 'true') {
      notificationsEnabled = true;
    } else {
      notificationsEnabled = false;
    }

    notifyListeners();
  }

  // Save dark mode setting to the database
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await DatabaseHelper.insertSetting('darkMode', _themeMode == ThemeMode.dark ? 'true' : 'false');
    notifyListeners();
  }

  // Add a new habit to the list and database
  Future<void> addHabit(String habitTitle) async {
    habits.add({'title': habitTitle, 'isChecked': false});
    await DatabaseHelper.insertHabit(habitTitle, false);
    notifyListeners();
  }

  // Remove habit from list and database
  Future<void> removeHabit(int index) async {
    String habitTitle = habits[index]['title'];
    await DatabaseHelper.removeHabit(habitTitle);
    habits.removeAt(index);
    notifyListeners();
  }

  // Toggle the checked state of a habit
  Future<void> toggleHabitCheck(int index, bool isChecked) async {
    habits[index]['isChecked'] = isChecked;
    String habitTitle = habits[index]['title'];
    await DatabaseHelper.updateHabit(habitTitle, isChecked);
    notifyListeners();
  }

  // Update the entire habits list
  Future<void> updateHabits(List<Map<String, dynamic>> newHabits) async {
    habits = newHabits;
    // Optionally, save the new habits to the database
    for (var habit in newHabits) {
      await DatabaseHelper.insertHabit(habit['title'], habit['isChecked']);
    }
    notifyListeners();
  }

  // Update quote and author
  void updateQuote(String newQuote, String newAuthor) {
    quote = newQuote;
    author = newAuthor;
    notifyListeners();
  }

  // Initialize notifications
  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Toggle notifications setting
  Future<void> toggleNotifications(bool value) async {
    notificationsEnabled = value;
    await DatabaseHelper.insertSetting('notificationsEnabled', notificationsEnabled ? 'true' : 'false');
    notifyListeners();
  }

  // Schedule a notification for a habit
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

