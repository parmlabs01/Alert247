import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The signature Alert 247 SOS button.
///
/// Behaviour (per PRD):
/// - Press & hold for 3 seconds triggers the emergency alert.
/// - While held, a countdown ring fills and a siren-style pulse plays.
/// - Releasing early cancels the countdown.
class SosButton extends StatefulWidget {
  const SosButton({
    super.key,
    required this.onTriggered,
    this.holdDuration = const Duration(seconds: 3),
    this.size = 220,
  });

  final VoidCallback onTriggered;
  final Duration holdDuration;
  final double size;

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _holdController;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _holdController = AnimationController(
      vsync: this,
      duration: widget.holdDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_triggered) {
          _triggered = true;
          widget.onTriggered();
          _holdController.reset();
        }
      });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _holdController.dispose();
    super.dispose();
  }

  void _onPressStart(_) {
    _triggered = false;
    _holdController.forward(from: 0);
  }

  void _onPressEnd(_) {
    if (!_triggered) _holdController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onPressStart,
      onTapUp: _onPressEnd,
      onTapCancel: () => _holdController.reverse(),
      child: SizedBox(
        width: widget.size * 1.5,
        height: widget.size * 1.5,
        child: AnimatedBuilder(
          animation: Listenable.merge([_pulseController, _holdController]),
          builder: (context, _) {
            final pulseScale = 1 + (_pulseController.value * 0.08);
            return Stack(
              alignment: Alignment.center,
              children: [
                // Outer siren glow.
                Transform.scale(
                  scale: pulseScale,
                  child: Container(
                    width: widget.size * 1.5,
                    height: widget.size * 1.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.redPulse(
                        opacity: 0.25 + (_pulseController.value * 0.15),
                      ),
                    ),
                  ),
                ),
                // Countdown progress ring.
                SizedBox(
                  width: widget.size + 24,
                  height: widget.size + 24,
                  child: CircularProgressIndicator(
                    value: _holdController.value == 0
                        ? null
                        : _holdController.value,
                    strokeWidth: 5,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.warningOrange,
                    ),
                  ),
                ),
                // Core button.
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF3B3B), AppColors.emergencyRed],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emergencyRed.withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_rounded,
                          color: Colors.white, size: 40),
                      const SizedBox(height: 6),
                      const Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _holdController.value > 0
                            ? 'Hold to send...'
                            : 'Press & hold 3s',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
