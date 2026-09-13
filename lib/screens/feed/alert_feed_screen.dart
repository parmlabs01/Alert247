import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class _FeedItem {
  final String title;
  final String detail;
  final String time;
  final IconData icon;
  final Color color;
  const _FeedItem(this.title, this.detail, this.time, this.icon, this.color);
}

class AlertFeedScreen extends StatelessWidget {
  const AlertFeedScreen({super.key});

  static const _items = [
    _FeedItem('Road Closure', 'Main St. closed due to accident cleanup near 4th Ave.',
        '5 min ago', Icons.construction_rounded, AppColors.warningOrange),
    _FeedItem('Weather Warning', 'Heavy rainfall expected — flash flood risk in low-lying areas.',
        '22 min ago', Icons.thunderstorm_rounded, Color(0xFF3B82F6)),
    _FeedItem('Security Advisory', 'Increased patrol requested in Downtown district tonight.',
        '1 hr ago', Icons.local_police_rounded, Color(0xFFA855F7)),
    _FeedItem('Nearby Incident', 'Minor fire reported and contained near Oakwood Plaza.',
        '2 hr ago', Icons.local_fire_department_rounded, AppColors.emergencyRed),
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
                child: Text('Alert Feed',
                    style: TextStyle(
                        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Text('Community safety updates near you',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final item = _items[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GlassCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: item.color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(item.icon, color: item.color, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title,
                                      style: const TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 4),
                                  Text(item.detail,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12)),
                                  const SizedBox(height: 6),
                                  Text(item.time,
                                      style: const TextStyle(
                                          color: AppColors.textMuted, fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
