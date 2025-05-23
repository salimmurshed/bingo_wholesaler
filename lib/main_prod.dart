// import 'package:die_friedliche_geburt/main.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   AppConfig devAppConfig = AppConfig(appName: 'geburt Prod', flavor: 'prod',baseUrl: 'https://prod.exmaple.com');
//   Widget app = await initializeApp(devAppConfig);
//   runApp(app);
// }

import 'app/app_config.dart';
import 'main.dart';

void main() async {
  ConstantEnvironment.setEnvironment(Environment.prod);
  await Future.delayed(Duration.zero);
  mainDelegate();
}
