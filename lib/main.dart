import 'package:flutter/material.dart';
import 'package:task/pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'theme.dart'; // Make sure theme.dart exists in lib/

void main() {
  runApp(const QuickTasksApp());
}

class QuickTasksApp extends StatelessWidget {
  const QuickTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTasks',
      debugShowCheckedModeBanner: false,
      theme: darkTheme, // Only dark theme used
      home: const SplashScreen(),
    );
  }
}
