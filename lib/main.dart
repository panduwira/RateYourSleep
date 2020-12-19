import 'package:flutter/material.dart';
import 'package:rateyoursleep/pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(),
        textSelectionColor: Colors.black
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(),
        textSelectionColor: Colors.white),
      themeMode: ThemeMode.system,
      home: MainMenu(),
    );
  }
}
