import 'package:flutter/material.dart';

class FormFieldModel {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final String helpText;
  final IconData icon;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final FocusNode? nextFocus;
  final bool isDatePicker;

  FormFieldModel({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    required this.helpText,
    required this.icon,
    this.isDatePicker = false,
    this.keyboard,
    this.validator,
    this.nextFocus,
  });
}