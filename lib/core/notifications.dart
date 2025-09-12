import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

final _locPlugin = FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iOSInit = DarwinInitializationSettings();
  await _locPlugin.initialize(
    const InitializationSettings(android: androidInit, iOS: iOSInit),
  );
}

Future<void> scheduleReminderEvery3Hours({required String id, required String title, required String body}) async {
  // On Android we can use periodic (or schedule) - for cross-platform we'll schedule next 3h and reschedule each time
  final now = DateTime.now().add(const Duration(second: 15));
  await _locPlugin.zonedSchedule(
    id.hashCode,
    title,
    body,
    tz.TZDateTime.from(now, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails('truth_ai_reminder', 'Truth AI reminders'),
      iOS: DarwinNotificationDetails(),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time, // not ideal — we reschedule manually typically
  );
}

Future<void> showImmediateReminder(String title, String body) async {
  await _locPlugin.show(
    0,
    title,
    body,
    const NotificationDetails(android: AndroidNotificationDetails('truth_ai_alert', 'Alerts')),
  );
}

Future<void> cancelAllReminders() => _locPlugin.cancelAll();