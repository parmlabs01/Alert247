import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alert247_logo.dart';
import '../onboarding/onboarding_screen.dart';

/// A single, continuous splash screen — no route/page swap in between.
/// One timeline crossfades from the Alert 247 mark into the
/// "from [Parm logo]" brand credit, then hands off to onboarding.
///
///   0%   – 6%   logo scales/fades in
///   6%   – 55%  logo holds, with a soft pulsing glow
///   55%  – 65%  crossfade: logo out, brand credit in
///   65%  – 100% brand credit holds
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _totalDuration = Duration(milliseconds: 3900);

  late final AnimationController _timeline;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();

    _timeline = AnimationController(vsync: this, duration: _totalDuration)
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
    _timeline.dispose();
    _pulse.dispose();
    super.dispose();
  }

  double _logoOpacity(double t) {
    if (t < 0.06) return t / 0.06;
    if (t < 0.55) return 1;
    if (t < 0.65) return 1 - ((t - 0.55) / 0.10);
    return 0;
  }

  double _brandOpacity(double t) {
    if (t < 0.55) return 0;
    if (t < 0.65) return (t - 0.55) / 0.10;
    return 1;
  }

  double _logoScale(double t) {
    final progress = (t / 0.06).clamp(0.0, 1.0);
    final eased = Curves.easeOutBack.transform(progress);
    return 0.85 + (eased * 0.15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.navyGlow),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_timeline, _pulse]),
              builder: (context, _) {
                final t = _timeline.value;
                final glow = 0.30 + (_pulse.value * 0.20);

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Logo phase.
                    Opacity(
                      opacity: _logoOpacity(t),
                      child: Transform.scale(
                        scale: _logoScale(t),
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
                    // Brand credit phase — "from" + Parm logo only.
                    Opacity(
                      opacity: _brandOpacity(t),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'from',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Image.asset(
                            'assets/images/parm_logo.png',
                            width: 220,
                            fit: BoxFit.contain,
                            color: Colors.white,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
