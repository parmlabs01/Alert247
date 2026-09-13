import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class FireScreen extends StatelessWidget {
  const FireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Fire Emergency',
      icon: Icons.local_fire_department_rounded,
      accent: AppColors.warningOrange,
      children: [
        GlassCard(
          borderColor: AppColors.warningOrange.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Report a Fire Outbreak',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                'Your exact location will be shared with the nearest fire '
                'station the moment you submit this report.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warningOrange),
                  onPressed: () => _confirm(context),
                  icon: const Icon(Icons.local_fire_department_rounded),
                  label: const Text('Report Fire & Request Response'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.add_a_photo_rounded, color: Colors.white70, size: 20),
                  SizedBox(width: 10),
                  Text('Attach photos or videos',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  3,
                  (i) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24, style: BorderStyle.solid),
                      ),
                      child: const Icon(Icons.add_rounded, color: Colors.white38),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const FeatureRow(icon: Icons.share_location_rounded, label: 'Shares your exact location'),
        const FeatureRow(icon: Icons.local_fire_department_rounded, label: 'Requests fire service response'),
        const FeatureRow(icon: Icons.notifications_active_rounded, label: 'Alerts nearby residents automatically'),
      ],
    );
  }

  void _confirm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.warningOrange,
        content: Text('Fire service alerted — response team is being dispatched.'),
      ),
    );
  }
}
