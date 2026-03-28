import 'package:flutter/material.dart';
import 'flutter_plugin_mini_api.dart';

/// UI class for Flutter Plugin Mini
/// Provides visual components based on the API class
class FlutterPluginMiniUI {
  /// A button that shows device info when clicked
  static Widget deviceInfoButton() {
    return _DeviceInfoButton();
  }
}



class _DeviceInfoButton extends StatefulWidget {
  @override
  _DeviceInfoButtonState createState() => _DeviceInfoButtonState();
}

class _DeviceInfoButtonState extends State<_DeviceInfoButton> {
  final FlutterPluginMiniApi _api = FlutterPluginMiniApi();
  Map<String, dynamic>? _deviceInfo;
  bool _isLoading = false;
  bool _showInfo = false;

  Future<void> _loadDeviceInfo() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final info = await _api.getDeviceInfo();
      setState(() {
        _deviceInfo = info;
        _isLoading = false;
        _showInfo = true;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : _loadDeviceInfo,
          child: _isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Show Device Info'),
        ),
        if (_showInfo && _deviceInfo != null)
          Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Device Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  ..._deviceInfo!.entries.map((entry) {
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
                ],
              ),
            ),
          ),
      ],
    );
  }
}