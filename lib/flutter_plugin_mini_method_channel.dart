import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_mini_platform_interface.dart';

/// An implementation of [FlutterPluginMiniPlatform] that uses method channels.
class MethodChannelFlutterPluginMini extends FlutterPluginMiniPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_plugin_mini');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map<String, dynamic>?> getDeviceInfo() async {
    final deviceInfo = await methodChannel.invokeMapMethod<String, dynamic>('getDeviceInfo');
    return deviceInfo;
  }
}
