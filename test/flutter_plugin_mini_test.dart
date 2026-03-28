import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_platform_interface.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPluginMiniPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPluginMiniPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<Map<String, dynamic>?> getDeviceInfo() => Future.value({
        'platform': 'Android',
        'version': '13',
        'model': 'Pixel 6',
        'manufacturer': 'Google',
        'device': 'oriole',
      });
}

void main() {
  final FlutterPluginMiniPlatform initialPlatform = FlutterPluginMiniPlatform.instance;

  test('$MethodChannelFlutterPluginMini is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPluginMini>());
  });

  test('getPlatformVersion', () async {
    FlutterPluginMini flutterPluginMiniPlugin = FlutterPluginMini();
    MockFlutterPluginMiniPlatform fakePlatform = MockFlutterPluginMiniPlatform();
    FlutterPluginMiniPlatform.instance = fakePlatform;

    expect(await flutterPluginMiniPlugin.getPlatformVersion(), '42');
  });
}
