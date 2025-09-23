import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();

  // New gradient colors for a dark, mysterious theme
  static const Color loginGradientStart = Color(0xFF1A237E); // Deep Indigo
  static const Color loginGradientEnd = Color(0xFF4A148C);   // Dark Purple
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}