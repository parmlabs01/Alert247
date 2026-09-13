import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class EmergencyMapScreen extends StatefulWidget {
  const EmergencyMapScreen({super.key});

  @override
  State<EmergencyMapScreen> createState() => _EmergencyMapScreenState();
}

class _EmergencyMapScreenState extends State<EmergencyMapScreen> {
  final _layers = const [
    ('Hospitals', Icons.local_hospital_rounded, AppColors.emergencyRed),
    ('Police', Icons.local_police_rounded, Color(0xFF3B82F6)),
    ('Fire Stations', Icons.local_fire_department_rounded, AppColors.warningOrange),
    ('Pharmacies', Icons.medication_rounded, AppColors.successGreen),
    ('Safe Zones', Icons.shield_rounded, Color(0xFF06B6D4)),
    ('Shelters', Icons.house_rounded, Color(0xFFA855F7)),
  ];

  final _active = <String>{'Hospitals', 'Police'};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.navyGlow),
      child: SafeArea(
        child: Stack(
          children: [
            // Map placeholder surface — replace with GoogleMap widget once
            // GOOGLE_MAPS_API_KEY is configured in Android/iOS platform files.
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0E1B3E), Color(0xFF050B1F)],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.map_rounded, color: Colors.white10, size: 160),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Emergency Map',
                      style: TextStyle(
                          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _layers.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final l = _layers[i];
                        final selected = _active.contains(l.$1);
                        return FilterChip(
                          label: Text(l.$1),
                          avatar: Icon(l.$2, size: 16, color: selected ? Colors.white : l.$3),
                          selected: selected,
                          onSelected: (v) => setState(() {
                            v ? _active.add(l.$1) : _active.remove(l.$1);
                          }),
                          selectedColor: l.$3.withOpacity(0.6),
                          backgroundColor: Colors.white.withOpacity(0.06),
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.white70,
                            fontSize: 12,
                          ),
                          side: BorderSide(color: l.$3.withOpacity(0.4)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: GlassCard(
                child: Row(
                  children: const [
                    Icon(Icons.my_location_rounded, color: AppColors.successGreen, size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Showing real-time locations near you. Tap a filter to toggle layers.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
