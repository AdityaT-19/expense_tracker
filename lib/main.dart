import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple,
);
var kdarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 32, 91, 107),
);

void main() {
  runApp(
    MaterialApp(
      home: const Expenses(),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kdarkScheme.onPrimaryContainer,
          foregroundColor: kdarkScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kdarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdarkScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kdarkScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kcolorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
    ),
  );
}
