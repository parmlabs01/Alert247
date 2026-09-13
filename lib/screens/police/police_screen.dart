import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class PoliceScreen extends StatelessWidget {
  const PoliceScreen({super.key});

  static const _categories = [
    ('Robbery Alert', Icons.local_police_rounded),
    ('Assault Report', Icons.report_problem_rounded),
    ('Kidnap Emergency', Icons.emergency_rounded),
    ('Crime Reporting', Icons.gavel_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF3B82F6);
    return FeatureScaffold(
      title: 'Police Assistance',
      icon: Icons.local_police_rounded,
      accent: accent,
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            for (final c in _categories)
              GlassCard(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: accent,
                    content: Text('${c.$1} submitted — nearest unit is being dispatched.'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(c.$2, color: accent, size: 22),
                    Text(c.$1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  StatusPill(label: 'LIVE DISPATCH', color: AppColors.successGreen),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Nearest patrol unit: Unit 12 — Downtown Precinct',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('Officer dispatch available for confirmed incidents.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
