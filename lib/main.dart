import 'package:flutter/material.dart';
import 'package:my_app_activity/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFEDE7F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6A1B9A),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF6A1B9A),
          selectedItemColor: Color(0xFFE040FB),
          unselectedItemColor: Color(0xFFCE93D8),
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFF3E5FF)),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
