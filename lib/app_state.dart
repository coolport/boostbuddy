import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // Quote-related state
  String _quote = "Loading quote...";
  String _author = "Loading...";
  String get quote => _quote;
  String get author => _author;

  void updateQuote(String newQuote, String newAuthor) {
    _quote = newQuote;
    _author = newAuthor;
    notifyListeners();
  }

  // Habit tracker state
  final List<String> _habits = [];
  List<String> get habits => List.unmodifiable(_habits);

  void addHabit(String habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void removeHabit(int index) {
    _habits.removeAt(index);
    notifyListeners();
  }
}
