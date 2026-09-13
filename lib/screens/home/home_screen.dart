import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/sos_button.dart';
import '../ambulance/ambulance_screen.dart';
import '../fire/fire_screen.dart';
import '../police/police_screen.dart';
import '../dispute/dispute_screen.dart';
import '../tracking/live_tracking_screen.dart';
import '../safewalk/safe_walk_screen.dart';
import '../chat/emergency_chat_screen.dart';
import '../incidents/incident_reporting_screen.dart';

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final WidgetBuilder builder;
  const _QuickAction(this.icon, this.label, this.color, this.builder);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final _actions = <_QuickAction>[
    _QuickAction(Icons.local_hospital_rounded, 'Ambulance',
        AppColors.emergencyRed, (_) => const AmbulanceScreen()),
    _QuickAction(Icons.local_fire_department_rounded, 'Fire',
        AppColors.warningOrange, (_) => const FireScreen()),
    _QuickAction(Icons.local_police_rounded, 'Police',
        const Color(0xFF3B82F6), (_) => const PoliceScreen()),
    _QuickAction(Icons.gavel_rounded, 'Report Dispute',
        const Color(0xFFA855F7), (_) => const DisputeScreen()),
    _QuickAction(Icons.share_location_rounded, 'Live Tracking',
        AppColors.successGreen, (_) => const LiveTrackingScreen()),
    _QuickAction(Icons.directions_walk_rounded, 'Safe Walk',
        const Color(0xFF06B6D4), (_) => const SafeWalkScreen()),
    _QuickAction(Icons.chat_bubble_rounded, 'Emergency Chat',
        const Color(0xFFEC4899), (_) => const EmergencyChatScreen()),
    _QuickAction(Icons.report_rounded, 'Report Incident',
        const Color(0xFFF59E0B), (_) => const IncidentReportingScreen()),
  ];

  void _showSosConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emergencyRed,
        content: Text(
          'SOS triggered — location, live tracking link and distress '
          'message sent to responders and emergency contacts.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.navyGlow),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Alert 247',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                        Text('Emergency Help. Anytime. Anywhere.',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                    const StatusPill(label: 'PROTECTED', color: AppColors.successGreen),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Column(
                  children: [
                    SosButton(onTriggered: () => _showSosConfirmation(context)),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: GlassCard(
                  child: Row(
                    children: const [
                      Icon(Icons.gps_fixed_rounded,
                          color: AppColors.successGreen, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Location sharing is active — your trusted '
                          'contacts can find you instantly in an emergency.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
              sliver: SliverToBoxAdapter(
                child: Text('Quick Actions',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.35,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final a = _actions[i];
                    return GlassCard(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: a.builder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: a.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(a.icon, color: a.color, size: 22),
                          ),
                          Text(a.label,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                        ],
                      ),
                    );
                  },
                  childCount: _actions.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
