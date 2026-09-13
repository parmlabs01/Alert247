import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class SafeWalkScreen extends StatefulWidget {
  const SafeWalkScreen({super.key});

  @override
  State<SafeWalkScreen> createState() => _SafeWalkScreenState();
}

class _SafeWalkScreenState extends State<SafeWalkScreen> {
  bool _active = false;
  double _minutes = 15;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF06B6D4);
    return FeatureScaffold(
      title: 'Safe Walk Mode',
      icon: Icons.directions_walk_rounded,
      accent: accent,
      children: [
        GlassCard(
          borderColor: _active ? accent.withOpacity(0.6) : null,
          child: Column(
            children: [
              Icon(
                _active ? Icons.timer_rounded : Icons.directions_walk_rounded,
                color: accent,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                _active ? 'Safe Walk is active' : 'Start a monitored trip',
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              if (!_active) ...[
                Text('Expected duration: ${_minutes.round()} min',
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                Slider(
                  value: _minutes,
                  min: 5,
                  max: 60,
                  divisions: 11,
                  activeColor: accent,
                  onChanged: (v) => setState(() => _minutes = v),
                ),
              ] else
                const Text(
                  'If you go inactive or miss your check-in, an SOS alert '
                  'is sent automatically to your emergency contacts.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _active ? AppColors.emergencyRed : accent,
                  ),
                  onPressed: () => setState(() => _active = !_active),
                  child: Text(_active ? 'End Safe Walk' : 'Start Safe Walk'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const FeatureRow(icon: Icons.share_location_rounded, label: 'Live tracking for the whole trip'),
        const FeatureRow(icon: Icons.hourglass_bottom_rounded, label: 'Countdown timer with check-ins'),
        const FeatureRow(icon: Icons.sos_rounded, label: 'Auto SOS if you become inactive'),
        const FeatureRow(icon: Icons.groups_rounded, label: 'Emergency contacts monitor your progress'),
      ],
    );
  }
}
