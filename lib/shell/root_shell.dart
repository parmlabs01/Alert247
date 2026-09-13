import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/feed/alert_feed_screen.dart';
import '../screens/map/emergency_map_screen.dart';
import '../screens/contacts/emergency_contacts_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../theme/app_theme.dart';

/// Hosts the 6 primary navigation tabs: Home, Alerts, Map, Contacts,
/// Profile, Settings.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    AlertFeedScreen(),
    EmergencyMapScreen(),
    EmergencyContactsScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  final _items = const [
    (Icons.home_rounded, 'Home'),
    (Icons.campaign_rounded, 'Alerts'),
    (Icons.map_rounded, 'Map'),
    (Icons.contacts_rounded, 'Contacts'),
    (Icons.person_rounded, 'Profile'),
    (Icons.settings_rounded, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          for (final item in _items)
            BottomNavigationBarItem(
              icon: Icon(item.$1),
              label: item.$2,
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
