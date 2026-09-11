import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.dark,
          surface: Color.fromARGB(255, 67, 168, 235)
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          // Text color inside the field
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          // Border styles
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
          ),
          // Fill
          filled: true,
          fillColor: Colors.white10,
          // Padding
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: SetupScreen(),
    ),
  );
}