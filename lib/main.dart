import 'package:flutter/material.dart';
import 'package:websocket_echo/infrastructure/flavor/custom_flavors.dart';
import 'package:websocket_echo/injectable.dart';

import 'app.dart';
import 'common/constants/app_const.dart';
import 'infrastructure/flavor/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CustomFlavors.init(url: AppConst.BASE_URL_PROD, flavor: Flavor.PROD, name: 'PROD');
  await configureInjection();
  runApp(const App());
}
