import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rateyoursleep/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: MainMenu(),
        theme: ThemeData(
            appBarTheme: AppBarTheme(),
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(),
            textSelectionColor: Colors.black,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white60, selectedItemColor: Colors.blueAccent),
            bottomAppBarColor: Colors.white,
           bottomAppBarTheme: BottomAppBarTheme(color: Colors.white) ),
        darkTheme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.blue[600]),
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(),
            textSelectionColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black, selectedItemColor: Colors.blue[500]),
            bottomAppBarColor: Colors.black,
            bottomAppBarTheme: BottomAppBarTheme(color: Colors.black)),
        themeMode: ThemeMode.system,
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(),
            textSelectionColor: Colors.black),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(),
            textSelectionColor: Colors.white),
        themeMode: ThemeMode.system,
      );
    }
  }
}
