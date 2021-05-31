import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rateyoursleep/pages/pages.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme(
              id: 'default_light_theme',
              data: ThemeData(
                  appBarTheme:
                      AppBarTheme(color: Colors.blue[400], centerTitle: true),
                  brightness: Brightness.light,
                  colorScheme: ColorScheme.light(
                    primary: Colors.blue,
                    secondary: Colors.lightBlue,
                    background: Colors.white60,
                    primaryVariant: Colors.blueAccent,
                    secondaryVariant: Colors.lightBlueAccent
                  ),
                  primaryColor: Colors.blue,
                  accentColor: Colors.blueAccent,
                  cardTheme: CardTheme(
                    color: Colors.white,
                    shadowColor: Colors.blueAccent
                    ),
                  backgroundColor: Colors.white,
                  buttonColor: Colors.grey,
                  primaryIconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  accentIconTheme: IconThemeData(
                    color: Colors.blueAccent
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.white60,
                      selectedItemColor: Colors.blueAccent),
                  bottomAppBarColor: Colors.white,
                  bottomAppBarTheme: BottomAppBarTheme(
                    color: Colors.white)),
              description: 'Basic Light Theme'),
          AppTheme(
              id: 'default_dark_theme',
              data: ThemeData(
                  appBarTheme:
                      AppBarTheme(color: Colors.blue[600], centerTitle: true),
                  brightness: Brightness.dark,
                  colorScheme: ColorScheme.dark(
                    primary: Colors.blue,
                    secondary: Colors.lightBlue,
                    background: Colors.white
                  ),
                  primaryColor: Colors.blue[750],
                  accentColor: Colors.blueAccent[400],
                  cardTheme: CardTheme(
                    color: Colors.black,
                    shadowColor: Colors.blueAccent[500]
                    ),
                  backgroundColor: Colors.black,
                  buttonColor: Colors.white,
                  primaryIconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  accentIconTheme: IconThemeData(
                    color: Colors.blueAccent
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.black,
                      selectedItemColor: Colors.blue[500]),
                  bottomAppBarColor: Colors.black,
                  bottomAppBarTheme: BottomAppBarTheme(color: Colors.black)),
              description: 'Basic Dark Theme'),
          AppTheme(
              id: 'extended_blue_theme',
              data: ThemeData(
                  appBarTheme:
                      AppBarTheme(color: Colors.blue[800], centerTitle: true),
                  colorScheme: ColorScheme.fromSwatch(
                    
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: Colors.blue,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.black),
                  bottomAppBarColor: Colors.blue[250],
                  bottomAppBarTheme: BottomAppBarTheme(
                    color: Colors.white)),
              description: 'Extended Blue Theme'),
        ],
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            home: MainMenu(),
            themeMode: ThemeMode.system,
          ),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(),),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(),),
        themeMode: ThemeMode.system,
      );
    }
  }
}
