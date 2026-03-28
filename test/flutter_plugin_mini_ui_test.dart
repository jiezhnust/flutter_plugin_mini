import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_ui.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterPluginMiniUI', () {
    setUp(() {
      // Set up mock platform
      FlutterPluginMiniPlatform.instance = MockFlutterPluginMiniPlatform();
    });

    testWidgets('miniDeviceInfoCard should render', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterPluginMiniUI.miniDeviceInfoCard(),
          ),
        ),
      );

      // Verify that the card is rendered
      expect(find.byType(Card), findsOneWidget);
      
      // Wait for the async operation to complete
      await tester.pumpAndSettle();
      
      // Verify that device info is displayed
      expect(find.text('Device Info'), findsOneWidget);
    });
  });
}

class MockFlutterPluginMiniPlatform extends FlutterPluginMiniPlatform {
  @override
  Future<String?> getPlatformVersion() {
    return Future.value('Android 13');
  }

  @override
  Future<Map<String, dynamic>?> getDeviceInfo() {
    return Future.value({
      'platform': 'Android',
      'version': '13',
      'model': 'Pixel 6',
      'manufacturer': 'Google',
      'device': 'oriole',
    });
  }
}