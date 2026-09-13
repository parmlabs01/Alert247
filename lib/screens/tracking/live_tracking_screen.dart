import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Live Tracking',
      icon: Icons.share_location_rounded,
      accent: AppColors.successGreen,
      children: [
        GlassCard(
          padding: EdgeInsets.zero,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF102040), Color(0xFF0B1530)],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.map_rounded, color: Colors.white24, size: 90),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: StatusPill(label: 'LIVE', color: AppColors.successGreen),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sharing with',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              for (final n in const ['Mom', 'David (Brother)', 'Home Security'])
                FeatureRow(icon: Icons.person_rounded, label: n,
                    trailing: const Icon(Icons.check_circle_rounded,
                        color: AppColors.successGreen, size: 18)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const FeatureRow(icon: Icons.route_rounded, label: 'Journey monitoring from start to destination'),
        const FeatureRow(icon: Icons.beach_access_rounded, label: 'Travel safety mode for trips & commutes'),
        const FeatureRow(icon: Icons.fence_rounded, label: 'Geofence alerts when you leave a safe zone'),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
            onPressed: () {},
            icon: const Icon(Icons.ios_share_rounded),
            label: const Text('Share My Live Location'),
          ),
        ),
      ],
    );
  }
}
