import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class _Contact {
  final String name;
  final String relation;
  final IconData icon;
  const _Contact(this.name, this.relation, this.icon);
}

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  static const _contacts = [
    _Contact('Amara Johnson', 'Family', Icons.family_restroom_rounded),
    _Contact('David Johnson', 'Family', Icons.family_restroom_rounded),
    _Contact('Priya Nair', 'Friend', Icons.person_rounded),
    _Contact('Mr. Adeyemi', 'Neighbor', Icons.home_rounded),
    _Contact('Titan Security Co.', 'Security', Icons.security_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.navyGlow),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 4),
                child: Text('Emergency Contacts',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              sliver: SliverToBoxAdapter(
                child: GlassCard(
                  borderColor: AppColors.emergencyRed.withOpacity(0.4),
                  child: Row(
                    children: [
                      const Icon(Icons.campaign_rounded, color: AppColors.emergencyRed),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'One-tap broadcast alerts every contact below at once.',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.emergencyRed,
                            content: Text('Group alert broadcast to all emergency contacts.'),
                          ),
                        ),
                        child: const Text('Broadcast'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final c = _contacts[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.08),
                              child: Icon(c.icon, color: Colors.white70, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.name,
                                      style: const TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.w600)),
                                  Text(c.relation,
                                      style: const TextStyle(
                                          color: AppColors.textMuted, fontSize: 12)),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_active_rounded,
                                  color: AppColors.warningOrange, size: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _contacts.length,
                ),
              ),
            ),
          ],
        ),
      ),
      // Add-contact FAB rendered by parent shell docked location if needed.
    );
  }
}
