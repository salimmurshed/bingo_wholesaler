import 'dart:io';

import 'package:flutter/foundation.dart';

import '/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../storage/db.dart';

@lazySingleton
class NotificationServices {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    prefs = await SharedPreferences.getInstance();

    // IosNotificationSettings(sound: true, badge: true, alert: true);
    await prefs.reload();
    debugPrint(prefs.getInt(DataBase.notificationNumber).toString());

    int v = prefs.getInt(DataBase.notificationNumber) ?? 0;
    await prefs.setInt(DataBase.notificationNumber, v + 1);
    int vv = prefs.getInt(DataBase.notificationNumber) ?? 0;
    debugPrint("xxx $vv");
  }

  @pragma('vm:entry-point')
  void onStart() {
    debugPrint('Handling a background message');
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel? channel;

  bool isFlutterLocalNotificationsInitialized = false;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? fcmDeviceToken = "";

  Future getFcmDeviceToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.requestPermission().then((v) async {
      if (Platform.isIOS) {
        String? apnToken = await firebaseMessaging.getAPNSToken();

        if (apnToken != null) {
          try {
            fcmDeviceToken = await firebaseMessaging.getToken();
          } catch (e) {
            fcmDeviceToken = "abcd";
          }
          // if (!kReleaseMode) {
          //   // print("dToken(${await FirebaseMessaging.instance.getToken()})");
          // } else {}
        }
      } else {
        fcmDeviceToken = await firebaseMessaging.getToken();
      }
    });
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('bajhbahdhajsbdjh');
  prefs = await SharedPreferences.getInstance();

  await prefs.reload();
  debugPrint(prefs.getInt(DataBase.notificationNumber).toString());
  debugPrint(message.data.toString());
  int v = prefs.getInt(DataBase.notificationNumber) ?? 0;
  await prefs.setInt(DataBase.notificationNumber, v + 1);
  int vv = prefs.getInt(DataBase.notificationNumber) ?? 0;
  debugPrint("xxx $vv");
}

class NotificationUtils {
  static Future<void> init() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_ID',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  static const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  static const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails(threadIdentifier: 'thread_id');
  static const InitializationSettings initializationSettings =
      InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
          ),
          macOS: null);
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
}
