import 'package:flutter/material.dart';

abstract class AppColors {
  // Light Theme Colors - Modern Blue & Purple Gradient
  static const Color lightPrimary = Color(0xFF6366F1); // Indigo-500
  static const Color lightPrimaryVariant = Color(0xFF4F46E5); // Indigo-600
  static const Color lightSecondary = Color(0xFF8B5CF6); // Purple-500
  static const Color lightSecondaryVariant = Color(0xFF7C3AED); // Purple-600
  static const Color lightBackground = Color(0xFFFAFAFA); // Neutral-50
  static const Color lightSurface = Color(0xFFFFFFFF); // White
  static const Color lightError = Color(0xFFEF4444); // Red-500
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1F2937); // Gray-800
  static const Color lightOnSurface = Color(0xFF1F2937); // Gray-800
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark Theme Colors - Modern Deep Blue & Purple
  static const Color darkPrimary = Color(0xFF818CF8); // Indigo-400
  static const Color darkPrimaryVariant = Color(0xFF6366F1); // Indigo-500
  static const Color darkSecondary = Color(0xFFA78BFA); // Purple-400
  static const Color darkSecondaryVariant = Color(0xFF8B5CF6); // Purple-500
  static const Color darkBackground = Color(0xFF0F172A); // Slate-900
  static const Color darkSurface = Color(0xFF1E293B); // Slate-800
  static const Color darkError = Color(0xFFF87171); // Red-400
  static const Color darkOnPrimary = Color(0xFF0F172A); // Slate-900
  static const Color darkOnSecondary = Color(0xFF0F172A); // Slate-900
  static const Color darkOnBackground = Color(0xFFF1F5F9); // Slate-100
  static const Color darkOnSurface = Color(0xFFF1F5F9); // Slate-100
  static const Color darkOnError = Color(0xFF0F172A); // Slate-900

  // Common Colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color info = Color(0xFF3B82F6); // Blue-500
  static const Color grey = Color(0xFF6B7280); // Gray-500
  static const Color greyLight = Color(0xFFD1D5DB); // Gray-300
  static const Color greyDark = Color(0xFF374151); // Gray-700
}
