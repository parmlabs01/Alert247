import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class _Message {
  final String text;
  final bool fromMe;
  final String time;
  const _Message(this.text, this.fromMe, this.time);
}

class EmergencyChatScreen extends StatefulWidget {
  const EmergencyChatScreen({super.key});

  @override
  State<EmergencyChatScreen> createState() => _EmergencyChatScreenState();
}

class _EmergencyChatScreenState extends State<EmergencyChatScreen> {
  final _controller = TextEditingController();
  final _messages = <_Message>[
    const _Message('Alert 247 Operator connected. How can we help?', false, '09:14'),
    const _Message('There has been a road accident near 5th Avenue.', true, '09:15'),
    const _Message('Understood — dispatching an ambulance now. Sharing your live location with responders.', false, '09:15'),
  ];

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_Message(_controller.text.trim(), true, 'now'));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.navyGlow),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.emergencyRed.withOpacity(0.2),
                      child: const Icon(Icons.support_agent_rounded,
                          color: AppColors.emergencyRed),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Emergency Operator',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w700)),
                          Text('Online · Responding',
                              style: TextStyle(color: AppColors.successGreen, fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.call_rounded, color: Colors.white70),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _messages.length,
                  itemBuilder: (context, i) {
                    final m = _messages[i];
                    return Align(
                      alignment: m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 280),
                        decoration: BoxDecoration(
                          color: m.fromMe
                              ? AppColors.emergencyRed
                              : Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.text, style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 4),
                            Text(m.time,
                                style: const TextStyle(color: Colors.white60, fontSize: 10)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _iconBtn(Icons.mic_rounded),
                    _iconBtn(Icons.photo_camera_rounded),
                    _iconBtn(Icons.share_location_rounded),
                    const SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: 'Message operator...'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: AppColors.emergencyRed,
                      child: IconButton(
                        onPressed: _send,
                        icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon) => IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white70, size: 20),
      );
}
