import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bingo/const/app_extensions/bools.dart';
import 'package:bingo/const/special_key.dart';
import 'package:bingo/services/notification_service/notification_servicee.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';
import '/my_app_files/my_app_web.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_config.dart';
import 'app/app_secrets.dart';
import 'app/locator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'my_app_files/my_app_mobile.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:encrypt/encrypt.dart' as encrypt;

late SharedPreferences prefs;
var navKey = locator<NavigationService>().navigatorKey;
var scaffoldKey = locator<NavigationService>().scaffoldKey;
late TabController tabController;

BuildContext get activeContext {
  assert(() {
    if (navKey.currentState == null) {
      throw FlutterError(
        'error in "context" getting',
      );
    }
    return true;
  }());

  return navKey.currentState!.context;
}

// => navKey.currentState!.context;
// Future<void> callEncryption() async {
//   String data = await rootBundle.loadString('assets/s/app_secrets_main.json');
//   var jsonResult = json.decode(data);
//   final encrypter = encrypt.Encrypter(
//       encrypt.AES(encrypt.Key.fromUtf8('ymQpRhvKirc8o2SbLwUWFmNxebdK27dU')));
//   final encrypted =
//       encrypter.encrypt(data, iv: encrypt.IV.fromUtf8('ymQpRhvKirc8o2Sb'));
//   log((encrypted.base16));
// }
// {"code": "dc18724e21e31bbc6d835a565285ca0bded85d5a6a3e83b7830c1a69e7a029f83fa2b4f4103247341845595ae6ce63e55dfdbab983ade162ece830b89985afa2829bf6b92098e2be71980960be039d3cfe0ed1ecaf46af7b4938b865c9fdcf53e05c0c18c2757fa4503b9741e97d479e16aea62e1f7dbe9579eaac578bd9b8bd750693238eb3c06ef4ce78f6a0be18547531a2f058d2a89220656b437d48269e94d21fcda155c8a52b34061d0ddef03c3f0f4b6544bd3f7b8b270993738da47b03950926c2f2ef8f6c38b4bfd5fa2a1f431fcd331ef30b053bdcea8dbc2bf24106ba1a82aa7655a42f92edb78ffc6eead0faac47d72eeca2ff862fa864011143189ab6e6514fe7a9bb904eb5f5d87d31d6e3894a30e71f1a14ab35863a0de6fc06efa403fd77819d8b9c7ca0a8b8306a33aa1e6ebbcfefc4b81ee6b81df3c609f11d192e83f3a2c64d3d728d096901bfbba82566cf287dc0d6b7f7f6ec8e9ba25cf7e122f808a99b25842ae31fa8539297dcfa5b973f9647a85b7c56bf238a967cb15187780558223f11b75573677a25b3de82aa4d7307287a86be6707f0d956dc037af0db8786d09e338a82d96c207d3e17ff98052e2fe6147af08d4380cc63f576bdcb06107745c1f24ce6438617d2bbf3e8f42e556ed4437ced850c1b199c4a08ccdc0d90f33531af1801641d8e42c35f14b56959e87fb77d7031754ea0e6f2a21fc7b294f4c0a10c2fccbf6db5536a63560196fb98c86a173db5fd3a2d95da18f97319d941e3c6a61ae03949d0e78ef42fb0e6860c9232c54556536726049d212c8144c5ad5cc4b5f7cfc8dd51fbeca98c1d760d7757fb165cbfd33cdbf8440b1f2efb16c0e8b1cc3c3f04c5efd03cacbe9609bcfbac15a65168f4f67184b6f771521fa12cc28b1bee3661ec4f95b18d014fe02f6f04c79b93e594de5a9ef3153f2724c793449636abf2e843f09e"}

Future<void> callEncryption() async {
  final encrypter = encrypt.Encrypter(encrypt.AES(SpecialKeys.key));
  String data = await rootBundle.loadString('/app/s/app_secrets_main.json');
  var jsonData = jsonDecode(data);
  String value = jsonData["code"];
  String bb = encrypter.decrypt16(value, iv: SpecialKeys.iv);
  print(bb);
  AppSecrets.encryptCode = jsonDecode(bb);
}

Future<void> mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await callEncryption();
  // await dotenv.load(fileName: "assets/s/.env");
  // print(dotenv.env['ESCAPED_DOLLAR_SIGN']);
  setupLocator();
  if (kIsWeb) {
    usePathUrlStrategy();
    // configureUrl();
    // usePathUrlStrategy();
  }
  prefs = await SharedPreferences.getInstance();

  if (!kIsWeb) {
    if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: AppSecrets.apiKey,
            appId: AppSecrets.appId,
            messagingSenderId: AppSecrets.messagingSenderId,
            projectId: AppSecrets.projectId),
      );
    } else if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: AppSecrets.apiKey,
            appId: ConstantEnvironment.environments == Environment.dev
                ? AppSecrets.appAndIdDev
                : AppSecrets.appAndIdQa,
            messagingSenderId: AppSecrets.messagingSenderId,
            projectId: AppSecrets.projectId),
      );
      //
      // FlutterError.onError =
      //     FirebaseCrashlytics.instance.recordFlutterFatalError;
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {}

    await NotificationUtils.init();
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: AppSecrets.apiKey,
          appId: AppSecrets.appId,
          messagingSenderId: AppSecrets.messagingSenderId,
          projectId: AppSecrets.projectId),
    );
  }

  if (kIsWeb) {
    runApp(const MyAppWeb());
  } else {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(const MyAppMobile()));
  }
}
