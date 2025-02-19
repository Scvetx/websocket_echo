import 'package:flutter/material.dart';

class UIUtils {
  /// Unfocus current focused UI element
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
