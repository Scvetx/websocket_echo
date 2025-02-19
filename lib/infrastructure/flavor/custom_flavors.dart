// Flutter imports:
import 'package:flutter/material.dart';
import 'package:websocket_echo/infrastructure/flavor/flavor_config.dart';

// Project imports:

class CustomFlavors {
  static FlavorConfig init(
      {required String url, required Flavor flavor, required String name}) {
    final values = FlavorValues(
      baseUrl: url,
      logNetworkInfo: true,
      showFullErrorMessages: true,
    );

    return FlavorConfig(
      flavor: flavor,
      name: name,
      color: Colors.red,
      values: values,
    );
  }

  static bool isDev() => FlavorConfig.isDev();
}
