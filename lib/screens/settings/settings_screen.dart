import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = true;
  bool _notifications = true;
  bool _panicShake = true;
  bool _shareLocationAlways = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.navyGlow),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Settings',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                children: [
                  _switchTile('Dark Mode', Icons.dark_mode_rounded, _darkMode,
                      (v) => setState(() => _darkMode = v)),
                  const Divider(color: AppColors.divider, height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.language_rounded, color: Colors.white70),
                    title: const Text('Language', style: TextStyle(color: Colors.white)),
                    trailing: DropdownButton<String>(
                      value: _language,
                      dropdownColor: AppColors.surfaceElevated,
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.white),
                      items: const ['English', 'Spanish', 'French', 'Arabic', 'Hausa']
                          .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                          .toList(),
                      onChanged: (v) => setState(() => _language = v ?? _language),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Notification Controls',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 8),
                  _switchTile('Push Notifications', Icons.notifications_active_rounded,
                      _notifications, (v) => setState(() => _notifications = v)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Emergency Preferences',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 8),
                  _switchTile('Panic Shake Activation', Icons.vibration_rounded,
                      _panicShake, (v) => setState(() => _panicShake = v)),
                  const Divider(color: AppColors.divider, height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.dialpad_rounded, color: Colors.white70),
                    title: const Text('Hold Duration for SOS', style: TextStyle(color: Colors.white)),
                    trailing: const Text('3s', style: TextStyle(color: AppColors.textMuted)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Privacy Settings',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 8),
                  _switchTile('Always Share Location', Icons.location_on_rounded,
                      _shareLocationAlways, (v) => setState(() => _shareLocationAlways = v)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text('Alert 247 · v1.0.0\nfrom PARM LABS',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchTile(String label, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white70),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        activeColor: AppColors.emergencyRed,
        onChanged: onChanged,
      ),
    );
  }
}
