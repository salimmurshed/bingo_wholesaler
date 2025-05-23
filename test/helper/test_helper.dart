import 'dart:io';
import 'dart:ui';

import 'package:bingo/const/database_helper.dart';
import 'package:bingo/repository/order_repository.dart';
import 'package:bingo/repository/repository_retailer.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:bingo/services/local_data/local_data.dart';
import 'package:bingo/services/navigation/navigation_service.dart';
import 'package:bingo/services/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:injectable/injectable.dart';
import 'package:bingo/repository/repository_components.dart';
import 'package:bingo/repository/repository_sales.dart';
import 'package:bingo/services/connectivity/connectivity.dart';
import 'package:bingo/services/network/web_service.dart';
import 'package:bingo/services/storage/device_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bingo/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'mock_path_provider.dart';
import 'test_helper.config.dart';
import 'test_helper.mocks.dart';

GetIt locator = GetIt.instance;
@InjectableInit(
  initializerName: 'testInit',
  preferRelativeImports: true,
  generateForDir: ['test', 'lib'],
)
@GenerateMocks([
  Path,
  http.Client,
  Directory,
  LocalData,
  ZDeviceStorage,
  DatabaseHelper,
  RepositorySales,
  NavigationService,
  WebService,
  Connectivity,
  RepositoryRetailer,
  RepositoryOrder,
  RepositoryWholesaler,
  RepositoryComponents,
  // ConnectivityService,
  // Connectivity,
  NetworkInfoService
], customMocks: [
  // MockSpec<Directory>(),
  // MockSpec<LocalData>(),
  // // MockSpec<DatabaseHelper>(),
  // MockSpec<ZDeviceStorage>(),
  // MockSpec<DatabaseHelper>(),
  // MockSpec<RepositorySales>(),
  // MockSpec<NavigationService>(),
  // // MockSpec<WebService>(),
  // MockSpec<ConnectivityService>(),
  // MockSpec<Connectivity>(),
  // MockSpec<NetworkInfoService>(),
])
Future<void> locatorSetup() async => locator.testInit();
Future<void> registerServices() async {
  // getAndRegisterUserService();
}

Future<void> sf() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
}

void unregisterServices() {
  // locator.unregister<ZDeviceStorage>();
  // locator.unregister<RepositorySales>();
  // locator.unregister<WebService>();
  // locator.unregister<LocalData>();
  if (locator.isRegistered<Connectivity>()) {
    locator.unregister<Connectivity>();
  }
}

MockRepositorySales getAndRegisterUserService({body}) {
  _removeRegistrationIfExists<RepositorySales>();
  final service = MockRepositorySales();
  when(service.addSales(body))
      .thenAnswer((realInvocation) => Future<AllSalesModel>.value(
            AllSalesModel(
              success: true,
            ),
          ));
  locator.registerSingleton<RepositorySales>(service);
  return service;
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
