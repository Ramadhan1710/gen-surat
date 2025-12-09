import 'package:flutter/material.dart';

mixin FocusScrollMixin<T extends StatefulWidget> on State<T> {
  void goNextField(FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (next.context != null) {
        Scrollable.ensureVisible(
          next.context!,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
