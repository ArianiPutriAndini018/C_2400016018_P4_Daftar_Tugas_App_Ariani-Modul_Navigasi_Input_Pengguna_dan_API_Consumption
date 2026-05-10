import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Tugas Ariani Putri Andini',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFE0D6B8),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF800000)),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF800000),
          elevation: 0,
          foregroundColor: Color(0xFFF8F4E9),
        ),
      ),
      home: const HomePage(),
    );
  }
}