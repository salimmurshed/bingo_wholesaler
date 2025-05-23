// void main() async {
//   AppConfig devAppConfig = AppConfig(appName: 'geburt Dev', flavor: 'dev', baseUrl: 'https://dev.exmaple.com');
//   Widget app = await initializeApp(devAppConfig);
//   runApp(app);
// }

import 'app/app_config.dart';
import 'main.dart';

void main() async {
  ConstantEnvironment.setEnvironment(Environment.qa);

  await Future.delayed(Duration.zero);
  mainDelegate();
}
