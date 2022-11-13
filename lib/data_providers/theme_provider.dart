import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color pageBackground = Colors.indigo[50]!;

  void changeThemeColor(Color color) {
    pageBackground = color;
    notifyListeners();
  }
}
