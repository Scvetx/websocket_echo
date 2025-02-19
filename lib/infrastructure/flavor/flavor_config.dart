// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum Flavor { DEV, PROD }

class FlavorValues {
  final String baseUrl;
  final bool logNetworkInfo;
  final bool showFullErrorMessages;

  FlavorValues({
    required this.baseUrl,
    required this.logNetworkInfo,
    required this.showFullErrorMessages,
  });
}

class FlavorConfig {
  double devicePixelRatio = 1;
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required Color color,
    required FlavorValues values,
  }) =>
      _instance = FlavorConfig._internal(flavor, name, color, values);

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance => _instance!;

  static bool get hasInstance => _instance != null;

  static bool isProd() => _instance!.flavor == Flavor.PROD;

  static bool isDev() => _instance!.flavor == Flavor.DEV;
}
