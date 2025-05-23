// import 'package:workmanager/workmanager.dart';
//
// Future<void> initializeService() async {
//   // final service = FlutterBackgroundService();
// }
//
// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     switch (taskName) {
//       case 'midnight_task':
//         try {
//           await SharedPrefsHelper()
//               .initSharedPrefsInstance(); //THIS line causes the error
//           await PedometerService.midnightTask();
//           debugPrint(
//               'workmanager_service.dart: looks like midnightTask got successfully executed :D');
//         } catch (e) {
//           debugPrint('workmanager_service.dart midnightTask error: $e');
//         }
//         break;
//       default:
//         debugPrint(
//             'workmanager_service.dart callbackDispatcher(): unhandled taskName: $taskName');
//     }
//     return Future.value(true); // "The task is successful"
//   });
// }
