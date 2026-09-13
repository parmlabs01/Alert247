import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class AmbulanceScreen extends StatelessWidget {
  const AmbulanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Ambulance Request',
      icon: Icons.local_hospital_rounded,
      accent: AppColors.emergencyRed,
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  StatusPill(label: 'NEAREST: 2.4 km', color: AppColors.successGreen),
                  SizedBox(width: 8),
                  StatusPill(label: 'ETA ~6 min', color: AppColors.warningOrange),
                ],
              ),
              const SizedBox(height: 14),
              const Text('City General Hospital Ambulance Unit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('Advanced life support · 2 paramedics on board',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _confirm(context),
                  icon: const Icon(Icons.local_hospital_rounded),
                  label: const Text('Request Ambulance Now'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('This request will share',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              SizedBox(height: 6),
              FeatureRow(icon: Icons.medical_information_rounded, label: 'Your medical profile'),
              FeatureRow(icon: Icons.share_location_rounded, label: 'Live GPS location'),
              FeatureRow(icon: Icons.timer_rounded, label: 'Real-time ETA tracking'),
              FeatureRow(icon: Icons.local_hospital_rounded, label: 'Nearby hospital suggestions'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('Suggested Hospitals',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 10),
        for (final h in const [
          ('City General Hospital', '2.4 km', 'Level 1 Trauma Center'),
          ('St. Mary Medical Center', '3.8 km', '24/7 Emergency Ward'),
          ('Riverside Health Clinic', '5.1 km', 'Urgent Care'),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GlassCard(
              child: Row(
                children: [
                  const Icon(Icons.local_hospital_rounded,
                      color: AppColors.emergencyRed),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(h.$1,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600)),
                        Text(h.$3,
                            style: const TextStyle(
                                color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                  Text(h.$2,
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _confirm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.emergencyRed,
        content: Text('Ambulance dispatched — ETA and live tracking sent to you.'),
      ),
    );
  }
}
