import 'package:flutter/material.dart';

class DocumentItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final bool isAvailable;
  final List<Color> gradient;

  DocumentItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.isAvailable,
    required this.gradient,
  });
}