import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';

import '../services/auth_service/auth_service.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_secrets.dart';
import '../app/locator.dart';
import '../app/router.dart';
import '../const/special_key.dart';
import '../l10n/l10n.dart';
import '../main.dart';

class MyAppMobile extends StatefulWidget {
  const MyAppMobile({Key? key}) : super(key: key);

  static Future setLocale(BuildContext context, Locale newLocale) async {
    _MyAppMobileState? state =
        context.findAncestorStateOfType<_MyAppMobileState>();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(DataBase.userLanguage, newLocale.languageCode);

    state?.setState(() {
      state._locale = newLocale;
    });
  }

  static void setLocaleClear(BuildContext context, Locale newLocale) async {
    _MyAppMobileState? state =
        context.findAncestorStateOfType<_MyAppMobileState>();
    state?.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  State<MyAppMobile> createState() => _MyAppMobileState();
}

class _MyAppMobileState extends State<MyAppMobile>
    with TickerProviderStateMixin<MyAppMobile>, WidgetsBindingObserver {
  getNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      firebaseMessaging.requestPermission().then((v) async {
        String? apns = await firebaseMessaging.getAPNSToken();
        if (apns != null) {
          try {
            await firebaseMessaging.getToken();
          } catch (_) {}
        }
      });
    } else {
      print("dToken(${await firebaseMessaging.getToken()})");
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        bool v = SpecialKeys.routeType
            .contains(event.data['notification_type'].toString());
        if (v) {
          locator<RepositoryNotification>().routeNotification(event.data);
        } else {
          locator<RepositoryNotification>().notificationCounter();
        }
      });
    });
    locator<RepositoryNotification>().getNotificationCounter();
    setState(() {});
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    bool status = prefs.getBool(DataBase.accountStatus) ?? false;

    if (state == AppLifecycleState.resumed) {
      prefs = await SharedPreferences.getInstance();
      if (!status) {
        locator<AuthService>().checkLockForResume();
      }
      setState(() {
        locator<RepositoryNotification>().getNotificationCounter();
      });
    } else if (state == AppLifecycleState.paused) {
      if (!status) {
        await prefs.setInt(
            DataBase.lastActiveTime, DateTime.now().millisecondsSinceEpoch);
      }
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
    debugPrint("MyAppMobile");
    tabController = TabController(length: 5, vsync: this);

    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      debugPrint("abcdefgh");
    }
    getNotification();

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
    return MaterialApp(
      locale: prefs.getString(DataBase.userLanguage) == null ? null : _locale,
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
      navigatorKey: navKey,
      theme: ThemeData(
          // textButtonTheme: ,
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.mainCardThemeRadius,
            ),
          ),
          dividerColor: AppColors.dividerColor,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            focusColor: AppColors.navFavColor,
            backgroundColor: AppColors.navFavColor,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.blackColor,
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
            thumbColor: WidgetStateProperty.all(AppColors.redColor),
            thickness: WidgetStateProperty.all(5.0),
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
      initialRoute: Routes.startupView,
      onGenerateRoute: Router().onGenerateRoute,
    );
  }
}
