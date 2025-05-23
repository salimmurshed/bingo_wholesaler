import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import '/repository/repository_components.dart';
import '/repository/repository_notification.dart';
import '/repository/repository_sales.dart';
import '/services/storage/db.dart';
import '/services/notification_service/notification_servicee.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_secrets.dart';
import '../app/locator.dart';
import '../app/web_route.dart';
import '../const/special_key.dart';
import '../const/web_devices.dart';
import '../l10n/l10n.dart';
import '../main.dart';

class MyAppWeb extends StatefulWidget {
  const MyAppWeb({Key? key}) : super(key: key);

  static Future setLocale(BuildContext context, Locale newLocale) async {
    _MyAppWebState? state = context.findAncestorStateOfType<_MyAppWebState>();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(DataBase.userLanguage, newLocale.languageCode);

    state?.setState(() {
      state._locale = newLocale;
    });
  }

  static void setLocaleClear(BuildContext context, Locale newLocale) async {
    _MyAppWebState? state = context.findAncestorStateOfType<_MyAppWebState>();
    state?.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  State<MyAppWeb> createState() => _MyAppWebState();
}

class _MyAppWebState extends State<MyAppWeb>
    with TickerProviderStateMixin<MyAppWeb>, WidgetsBindingObserver {
  // getNotification() async {
  //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     FirebaseMessaging.onMessage.listen((event) {
  //       locator<RepositoryNotification>().notificationCounter();
  //     });
  //   });
  //   locator<RepositoryNotification>().getNotificationCounter();
  //   setState(() {});
  // }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        locator<RepositoryNotification>().getNotificationCounter();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // getNotification();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
    ));
    _fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      locator<RepositorySales>().offlineSalesAddToServer();
      if (result.name.toLowerCase() == "none") {
        locator<RepositoryComponents>().changeInternetStatus(false);
      } else {
        locator<RepositoryComponents>().changeInternetStatus(true);
      }
    });
  }

  Future<Locale> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    Locale deviceLocale = window.locale;
    String langCode = deviceLocale.languageCode;
    String selectedLangCode =
        langCode != "en" || langCode != "es" ? "en" : langCode;
    String languageCode = prefs.getString(DataBase.userLanguage) == "" ||
            prefs.getString(DataBase.userLanguage) == null
        ? selectedLangCode
        : prefs.getString(DataBase.userLanguage)!;

    return Locale(
      languageCode,
    );
  }

  Locale _locale = Locale(SpecialKeys.languageEn);

  @override
  Widget build(BuildContext context) {
    final shortcuts = Map.of(WidgetsApp.defaultShortcuts);
    shortcuts[LogicalKeySet(LogicalKeyboardKey.enter)] = const ActivateIntent();

    changedDeviceOrientation(context);
    return FlutterBootstrap5(
      builder: (context) {
        return MaterialApp.router(
          shortcuts: kIsWeb ? shortcuts : null,
          locale:
              prefs.getString(DataBase.userLanguage) == null ? null : _locale,
          // locale: locator<AuthService>().selectedLocal.value,
          localizationsDelegates: const [
            // FallbackLocalizationDelegate(),
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,

          debugShowCheckedModeBanner: false,
          title: AppSecrets.appName,
          theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.android:
                      FadeUpwardsPageTransitionsBuilder(), // Apply this to every platforms you need.
                },
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mainCardThemeRadius,
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                focusColor: AppColors.navFavColor,
                backgroundColor: AppColors.navFavColor,
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.bingoGreen,
                selectionColor: AppColors.bingoGreen.withOpacity(0.7),
              ),
              primarySwatch: AppColors.primarySwatch,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: AppColors.primarySwatch,
                accentColor: AppColors.accentColor,
              ),
              scrollbarTheme: ScrollbarThemeData(
                interactive: true,
                radius: const Radius.circular(10.0),
                thumbColor: MaterialStateProperty.all(AppColors.scrollBarColor),
                thickness: MaterialStateProperty.all(5.0),
                minThumbLength: 100,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: AppColors.backgroundSecondary,
              appBarTheme: const AppBarTheme(
                color: AppColors.accentColor,
                titleTextStyle: AppTextStyles.appBarTitle,
                elevation: 0.5,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: AppColors.appBarText,
                ),
              ),
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.mainDialogThemeRadius,
                ),
              ),
              fontFamily: SpecialKeys.poppins),
          routerConfig: router,
        );
      },
    );
  }
}
