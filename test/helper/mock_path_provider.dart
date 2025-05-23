import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'test_helper.mocks.dart';

class FakePathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/fake/path';
  }

  Future<Directory> getApplicationDocumentsDirectory() async {
    return Directory('/fake/path');
  }

// Implement other methods if needed
}

// class MockPathProvider extends Mock implements PathProviderPlatform {
//   Future<Directory> getApplicationDocumentsDirectory() async {
//     return Directory('/fake/path');
//   }
// }

class MockPathProvider extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {}

Future<void> registerMockPathProvider() async {
  // final appDocDir = await getApplicationDocumentsDirectory();
  final mockPathProvider = MockPathProvider();

  when(mockPathProvider.getApplicationDocumentsPath()).thenAnswer(
    (_) async =>
        (Directory(path.join(Directory.current.path, 'test/mock_path')).path),
  );

  PathProviderPlatform.instance = mockPathProvider;
}
