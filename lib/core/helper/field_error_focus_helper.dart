import 'package:flutter/material.dart';

class FieldErrorFocusHelper {
  /// Focuses the first field that has an error in the form.
  static void focusFirstErrorField(List<FocusErrorField> errorFields) {
    for (final field in errorFields) {
      if (field.hasError()) {
        field.focusNode.requestFocus();
        return;
      }
    }
  }
}

class FocusErrorField {
  final bool Function() hasError;
  final FocusNode focusNode;

  FocusErrorField({required this.hasError, required this.focusNode});
}
