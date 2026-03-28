import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_api.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterPluginMiniApi', () {
    late FlutterPluginMiniApi api;
    late MockFlutterPluginMiniPlatform mockPlatform;

    setUp(() {
      mockPlatform = MockFlutterPluginMiniPlatform();
      FlutterPluginMiniPlatform.instance = mockPlatform;
      api = FlutterPluginMiniApi();
    });

    test('getDeviceInfo should return device info', () async {
      // Arrange
      final expectedDeviceInfo = {
        'platform': 'Android',
        'version': '13',
        'model': 'Pixel 6',
        'manufacturer': 'Google',
        'device': 'oriole',
      };
      mockPlatform.deviceInfo = expectedDeviceInfo;

      // Act
      final result = await api.getDeviceInfo();

      // Assert
      expect(result, equals(expectedDeviceInfo));
    });
  });
}

class MockFlutterPluginMiniPlatform extends FlutterPluginMiniPlatform {
  Map<String, dynamic>? deviceInfo;

  @override
  Future<String?> getPlatformVersion() {
    return Future.value('Android 13');
  }

  @override
  Future<Map<String, dynamic>?> getDeviceInfo() {
    return Future.value(deviceInfo);
  }
}