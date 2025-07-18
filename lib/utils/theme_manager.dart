import 'package:flutter/material.dart';

ThemeData getThemeByHouse(String house) {
  switch (house.toLowerCase()) {
    case 'slytherin':
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A472A), // verde oscuro
          primary: const Color(0xFF1A472A),
          secondary: const Color(0xFFA5A5A5), // plateado
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1B12),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A472A),
        ),
        fontFamily: 'LibreBaskerville',
        useMaterial3: true,
      );

    case 'ravenclaw':
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF222F5B), // azul oscuro
          primary: const Color(0xFF222F5B),
          secondary: const Color(0xFF946B2D), // bronce
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF222F5B),
        ),
        fontFamily: 'LibreBaskerville',
        useMaterial3: true,
      );

    case 'hufflepuff':
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700), // dorado/amarillo
          primary: const Color(0xFFFFD700),
          secondary: const Color(0xFF1A1A1A), // negro
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Colors.black,
        ),
        fontFamily: 'LibreBaskerville',
        useMaterial3: true,
      );

    case 'gryffindor':
    default:
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7F0909), // rojo oscuro
          primary: const Color(0xFF7F0909),
          secondary: const Color(0xFFFFD700), // dorado
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1C0B0B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7F0909),
        ),
        fontFamily: 'LibreBaskerville',
        useMaterial3: true,
      );
  }
}
