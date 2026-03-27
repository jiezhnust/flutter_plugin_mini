import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_api.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Map<String, dynamic>? _deviceInfo;
  final _flutterPluginMiniPlugin = FlutterPluginMini();
  final _api = FlutterPluginMiniApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadDeviceInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterPluginMiniPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> loadDeviceInfo() async {
    try {
      final info = await _api.getDeviceInfo();
      if (!mounted) return;
      setState(() {
        _deviceInfo = info;
      });
    } on PlatformException {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Running on: $_platformVersion\n'),
                ),
              ),
              // API Usage Example
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('API Usage Example', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text('Device Info from API:'),
                        SizedBox(height: 8),
                        _deviceInfo != null
                            ? Column(
                                children: _deviceInfo!.entries.map((entry) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(entry.key, style: TextStyle(color: Colors.grey)),
                                        Text(entry.value.toString()),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            : Text('Loading device info...'),
                      ],
                    ),
                  ),
                ),
              ),
              // UI Component Example
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UI Component Example', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        FlutterPluginMiniUI.miniDeviceInfoCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
