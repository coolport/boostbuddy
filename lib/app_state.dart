import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String quote = "Loading quote...";
  String author = "Loading...";
  
  List<Map<String, dynamic>> habits = [
    {'title': 'Exercise for 30 mins', 'isChecked': false},
    {'title': 'Fetch dynamic background images', 'isChecked': false},
    {'title': 'Change AppBar to add Stories tab', 'isChecked': false},
    {'title': 'Make this list dynamic', 'isChecked': false},
    {'title': 'Add user notifications', 'isChecked': false},
  ];

  void updateQuote(String newQuote, String newAuthor) {
    quote = newQuote;
    author = newAuthor;
    notifyListeners();
  }

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
}
