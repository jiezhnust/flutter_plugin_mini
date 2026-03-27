import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_mini/flutter_plugin_mini.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic>? _deviceInfo;
  final _api = FlutterPluginMiniApi();

  @override
  void initState() {
    super.initState();
    loadDeviceInfo();
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
              // Device Info Button Example
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Device Info Button Example', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Center(child: FlutterPluginMiniUI.deviceInfoButton()),
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
