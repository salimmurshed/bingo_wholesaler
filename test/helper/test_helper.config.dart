// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bingo/repository/order_repository.dart' as _i13;
import 'package:bingo/repository/repository_components.dart' as _i11;
import 'package:bingo/repository/repository_customer.dart' as _i6;
import 'package:bingo/repository/repository_notification.dart' as _i12;
import 'package:bingo/repository/repository_retailer.dart' as _i14;
import 'package:bingo/repository/repository_sales.dart' as _i15;
import 'package:bingo/repository/repository_website_sale.dart' as _i17;
import 'package:bingo/repository/repository_website_settings.dart' as _i18;
import 'package:bingo/repository/repository_website_statements.dart' as _i19;
import 'package:bingo/repository/repository_wholesaler.dart' as _i20;
import 'package:bingo/repository/settlement_repository.dart' as _i16;
import 'package:bingo/services/auth_service/auth_service.dart' as _i3;
import 'package:bingo/services/connectivity/connectivity.dart' as _i4;
import 'package:bingo/services/local_data/local_data.dart' as _i7;
import 'package:bingo/services/navigation/navigation_service.dart' as _i8;
import 'package:bingo/services/network.dart' as _i5;
import 'package:bingo/services/network/network_info.dart' as _i9;
import 'package:bingo/services/network/web_service.dart' as _i23;
import 'package:bingo/services/notification_service/notification_servicee.dart'
    as _i10;
import 'package:bingo/services/storage/device_storage.dart' as _i24;
import 'package:bingo/services/web_basic_service/WebBasicService.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i21;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> testInit({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final deviceStorageServiceAbstract = _$DeviceStorageServiceAbstract();
    gh.lazySingleton<_i3.AuthService>(() => _i3.AuthService());
    gh.lazySingleton<_i4.ConnectivityService>(() => _i4.ConnectivityService());
    gh.lazySingleton<_i5.ConnectivityServices>(
        () => _i5.ConnectivityServices());
    gh.lazySingleton<_i6.CustomerRepository>(() => _i6.CustomerRepository());
    gh.lazySingleton<_i7.LocalData>(() => _i7.LocalData());
    gh.lazySingleton<_i8.NavigationService>(() => _i8.NavigationService());
    gh.lazySingleton<_i9.NetworkInfoService>(() => _i9.NetworkInfoService());
    gh.lazySingleton<_i10.NotificationServices>(
        () => _i10.NotificationServices());
    gh.lazySingleton<_i11.RepositoryComponents>(
        () => _i11.RepositoryComponents());
    gh.lazySingleton<_i12.RepositoryNotification>(
        () => _i12.RepositoryNotification());
    gh.lazySingleton<_i13.RepositoryOrder>(() => _i13.RepositoryOrder());
    gh.lazySingleton<_i14.RepositoryRetailer>(() => _i14.RepositoryRetailer());
    gh.lazySingleton<_i15.RepositorySales>(() => _i15.RepositorySales());
    gh.lazySingleton<_i16.RepositorySettlement>(
        () => _i16.RepositorySettlement());
    gh.lazySingleton<_i17.RepositoryWebsiteSales>(
        () => _i17.RepositoryWebsiteSales());
    gh.lazySingleton<_i18.RepositoryWebsiteSettings>(
        () => _i18.RepositoryWebsiteSettings());
    gh.lazySingleton<_i19.RepositoryWebsiteStatement>(
        () => _i19.RepositoryWebsiteStatement());
    gh.lazySingleton<_i20.RepositoryWholesaler>(
        () => _i20.RepositoryWholesaler());
    await gh.factoryAsync<_i21.SharedPreferences>(
      () => deviceStorageServiceAbstract.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i22.WebBasicService>(() => _i22.WebBasicService());
    gh.lazySingleton<_i23.WebService>(() => _i23.WebService());
    gh.singleton<_i24.ZDeviceStorage>(() => _i24.ZDeviceStorage());
    return this;
  }
}

class _$DeviceStorageServiceAbstract
    extends _i24.DeviceStorageServiceAbstract {}
