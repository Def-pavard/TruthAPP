import 'package:flutter/services.dart';

class MonitorChannel {
  static const MethodChannel _channel = MethodChannel('truth_ai/monitor');

  static Future<void> startMonitor() async {
    await _channel.invokeMethod('startMonitor');
  }
  static Future<void> stopMonitor() async {
    await _channel.invokeMethod('stopMonitor');
  }
  static Future<bool> isMonitoring() async {
    return await _channel.invokeMethod('isMonitoring') ?? false;
  }
  static Future<void> openUsageAccessSettings() async {
    await _channel.invokeMethod('openUsageAccessSettings');
  }
  static Future<void> openOverlaySettings() async {
    await _channel.invokeMethod('openOverlaySettings');
  }
}