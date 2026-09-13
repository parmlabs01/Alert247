import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class IncidentReportingScreen extends StatelessWidget {
  const IncidentReportingScreen({super.key});

  static const _categories = [
    ('Accident', Icons.car_crash_rounded, Color(0xFFF97316)),
    ('Fire', Icons.local_fire_department_rounded, Color(0xFFFF0000)),
    ('Theft', Icons.remove_red_eye_rounded, Color(0xFFA855F7)),
    ('Assault', Icons.pan_tool_rounded, Color(0xFF3B82F6)),
    ('Missing Person', Icons.person_search_rounded, Color(0xFF06B6D4)),
    ('Medical Emergency', Icons.medical_services_rounded, Color(0xFFFF0000)),
    ('Natural Disaster', Icons.storm_rounded, Color(0xFFF59E0B)),
    ('Road Hazard', Icons.warning_amber_rounded, Color(0xFF22C55E)),
  ];

  @override
  Widget build(BuildContext context) {
    return FeatureScaffold(
      title: 'Incident Reporting',
      icon: Icons.report_rounded,
      accent: const Color(0xFFF59E0B),
      children: [
        const Text('Select a category to report',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            for (final c in _categories)
              GlassCard(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: c.$3,
                    content: Text('${c.$1} report started — add details and evidence.'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(c.$2, color: c.$3, size: 22),
                    Text(c.$1,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
