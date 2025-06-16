import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  runApp(const QuickTasksApp());
}

class QuickTasksApp extends StatefulWidget {
  const QuickTasksApp({super.key});

  @override
  State<QuickTasksApp> createState() => _QuickTasksAppState();
}

class _QuickTasksAppState extends State<QuickTasksApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTasks',
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: HomePage(toggleTheme: toggleTheme, isDark: isDark),
    );
  }
}
