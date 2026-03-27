import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_plugin_mini_method_channel.dart';

abstract class FlutterPluginMiniPlatform extends PlatformInterface {
  /// Constructs a FlutterPluginMiniPlatform.
  FlutterPluginMiniPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPluginMiniPlatform _instance = MethodChannelFlutterPluginMini();

  /// The default instance of [FlutterPluginMiniPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPluginMini].
  static FlutterPluginMiniPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPluginMiniPlatform] when
  /// they register themselves.
  static set instance(FlutterPluginMiniPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
