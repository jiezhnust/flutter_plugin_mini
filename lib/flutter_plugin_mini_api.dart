import 'flutter_plugin_mini_platform_interface.dart';

/// API class for Flutter Plugin Mini
/// Provides core functionality without UI dependencies
class FlutterPluginMiniApi {
  /// Get device information
  /// Returns a map containing device details such as platform version, battery level, etc.
  Future<Map<String, dynamic>?> getDeviceInfo() {
    return FlutterPluginMiniPlatform.instance.getDeviceInfo();
  }
}