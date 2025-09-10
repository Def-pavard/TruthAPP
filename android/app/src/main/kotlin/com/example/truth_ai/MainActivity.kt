#package com.thruthai.truthapp; // Mets ici ton vrai package

#import io.flutter.embedding.android.FlutterActivity;

#public class MainActivity extends FlutterActivity

  package com.thruthai.truthapp

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "truth_ai/monitor"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
      when (call.method) {
        "startMonitor" -> {
          val intent = Intent(this, AppUsageMonitorService::class.java)
          startForegroundService(intent)
          result.success(null)
        }
        "stopMonitor" -> {
          val intent = Intent(this, AppUsageMonitorService::class.java)
          stopService(intent)
          result.success(null)
        }
        "isMonitoring" -> {
          // Could check service state via a static flag
          result.success(AppUsageMonitorService.isRunning)
        }
        else -> result.notImplemented()
      }
    }
  }
}
