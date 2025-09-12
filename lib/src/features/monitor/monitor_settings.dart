import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../platform/monitor_channel.dart';
import '../../core/notifications.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonitorSettings extends StatefulWidget {
  const MonitorSettings({super.key});
  @override
  State<MonitorSettings> createState() => _MonitorSettingsState();
}

class _MonitorSettingsState extends State<MonitorSettings> {
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _init();
  }
  Future<void> _init() async {
    final r = await MonitorChannel.isMonitoring();
    setState(() => _running = r);
  }

  Future<void> _enable() async {
    // Ask overlay permission (opens settings on Android)
    await MonitorChannel.openOverlaySettings();
    // Ask user to grant Usage Access (opens settings)
    await MonitorChannel.openUsageAccessSettings();
    // Start the native service
    await MonitorChannel.startMonitor();
    await initLocalNotifications();
    setState(() => _running = true);
  }

  Future<void> _disable() async {
    await MonitorChannel.stopMonitor();
    await cancelAllReminders();
    setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return ListTile(
      title: Text(t.enableSocialVigil ?? 'Enable Social Vigil'),
      subtitle: Text(t.socialVigilDescription),
      trailing: Switch(
        value: _running,
        onChanged: (v) async {
          if (v) {
            await _enable();
          } else {
            await _disable();
          }
        },
      ),
    );
  }
}