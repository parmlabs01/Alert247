import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alert247_logo.dart';
import '../onboarding/onboarding_screen.dart';

/// A single splash screen — matching the "from Meta" pattern used by
/// Instagram/WhatsApp/Facebook: the main Alert 247 mark is centered,
/// and the "from PARM" brand credit sits small at the bottom of the
/// *same* screen. There is no second screen/route — everything fades
/// in together, holds, then hands off once to onboarding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _totalDuration = Duration(milliseconds: 2800);

  late final AnimationController _entrance;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(vsync: this, duration: _totalDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _goToOnboarding();
      })
      ..forward();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat(reverse: true);
  }

  void _goToOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, anim, __) => const OnboardingScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  // Everything fades/scales in together over the first 20% of the
  // timeline, then holds for the rest of the splash duration.
  double _fadeIn(double t) => (t / 0.20).clamp(0.0, 1.0);

  double _scaleIn(double t) {
    final progress = (t / 0.20).clamp(0.0, 1.0);
    final eased = Curves.easeOutBack.transform(progress);
    return 0.85 + (eased * 0.15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.navyGlow),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: Listenable.merge([_entrance, _pulse]),
            builder: (context, _) {
              final t = _entrance.value;
              final opacity = _fadeIn(t);
              final scale = _scaleIn(t);
              final glow = 0.30 + (_pulse.value * 0.20);

              return Stack(
                children: [
                  // Main mark, centered.
                  Center(
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.redPulse(opacity: glow),
                              ),
                              child: const Alert247Logo(size: 190),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'ALERT 247',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Emergency Help. Anytime. Anywhere.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // "from PARM" brand credit — small, bottom of the
                  // same screen, Meta-style.
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: Opacity(
                      opacity: opacity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'from',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Image.asset(
                            'assets/images/parm_logo.png',
                            width: 110,
                            fit: BoxFit.contain,
                            color: Colors.white70,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
