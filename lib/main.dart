import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app_state.dart';
import 'motivator_home_page.dart';
import 'stories_page.dart';
import 'settings_page.dart';

// Initialize the notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Detroit')); // Update with your time zone

  // Notification setup
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return MaterialApp(
      title: 'BoostBuddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: appState.themeMode,
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    MotivatorHomePage(),
    StoriesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Homepage'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Stories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Helper function to schedule a notification
Future<void> scheduleNotification(
    String title, String body, DateTime scheduledTime) async {
  // Convert the scheduledTime to TZDateTime
  final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Unique ID for the notification
    title,
    body,
    tzScheduledTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_reminder_channel',
        'Habit Reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exact, // Specify the schedule mode
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}

