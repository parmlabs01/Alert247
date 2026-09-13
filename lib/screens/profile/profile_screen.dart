import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.navyGlow),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Profile',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: AppColors.emergencyRed.withOpacity(0.2),
                    child: const Icon(Icons.person_rounded, color: AppColors.emergencyRed, size: 42),
                  ),
                  const SizedBox(height: 12),
                  const Text('Jordan Michaels',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  const Text('+1 (555) 010-2947',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Medical Information',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  _row('Blood Group', 'O+', AppColors.emergencyRed),
                  _row('Allergies', 'Penicillin, Peanuts', AppColors.warningOrange),
                  _row('Conditions', 'Asthma', AppColors.successGreen),
                  _row('Insurance', 'BlueShield #A29104', Colors.white70),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Account',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  _tile(Icons.edit_rounded, 'Edit Profile'),
                  _tile(Icons.medical_information_rounded, 'Update Medical Info'),
                  _tile(Icons.family_restroom_rounded, 'Manage Emergency Contacts'),
                  _tile(Icons.logout_rounded, 'Log Out', color: AppColors.emergencyRed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, Color valueColor) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
            Text(value, style: TextStyle(color: valueColor, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      );

  Widget _tile(IconData icon, String label, {Color color = Colors.white}) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: color, size: 20),
        title: Text(label, style: TextStyle(color: color, fontSize: 14)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white24),
        onTap: () {},
      );
}
