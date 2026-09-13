import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_scaffold.dart';

class DisputeScreen extends StatefulWidget {
  const DisputeScreen({super.key});

  @override
  State<DisputeScreen> createState() => _DisputeScreenState();
}

class _DisputeScreenState extends State<DisputeScreen> {
  String _type = 'Community Conflict';
  final _types = const [
    'Community Conflict',
    'Road Incident',
    'Violence Report',
    'Public Disturbance',
  ];

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFA855F7);
    return FeatureScaffold(
      title: 'Report Dispute',
      icon: Icons.gavel_rounded,
      accent: accent,
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dispute Type',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in _types)
                    ChoiceChip(
                      label: Text(t),
                      selected: _type == t,
                      onSelected: (_) => setState(() => _type = t),
                      selectedColor: accent.withOpacity(0.25),
                      labelStyle: TextStyle(
                        color: _type == t ? Colors.white : Colors.white70,
                        fontSize: 12,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.05),
                      side: BorderSide(
                        color: _type == t ? accent : Colors.white24,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Describe what is happening...',
                  hintStyle: const TextStyle(color: AppColors.textMuted),
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
              const Text('Attach Evidence',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _evidenceButton(Icons.mic_rounded, 'Voice'),
                  const SizedBox(width: 10),
                  _evidenceButton(Icons.photo_camera_rounded, 'Photo'),
                  const SizedBox(width: 10),
                  _evidenceButton(Icons.videocam_rounded, 'Video'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accent),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: accent,
                content: Text('$_type reported — live updates will follow.'),
              ),
            ),
            child: const Text('Submit Report'),
          ),
        ),
      ],
    );
  }

  Widget _evidenceButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
