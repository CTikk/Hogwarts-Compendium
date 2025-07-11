import 'package:flutter/material.dart';

ThemeData getThemeByHouse(String house) {
  switch (house.toLowerCase()) {
    case 'slytherin':
      return ThemeData(primarySwatch: Colors.green);
    case 'ravenclaw':
      return ThemeData(primarySwatch: Colors.blueGrey);
    case 'hufflepuff':
      return ThemeData(primarySwatch: Colors.amber);
    case 'gryffindor':
    default:
      return ThemeData(primarySwatch: Colors.red);
  }
}