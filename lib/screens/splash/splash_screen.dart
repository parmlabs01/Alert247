import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../onboarding/onboarding_screen.dart';

/// Splash flow:
///   Screen 1 — Alert 247 logo fades in with a red pulse glow (2–2.5s)
///   Screen 2 — "from" + Parm logo brand attribution, white on navy (1.5s)
/// then navigates to onboarding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  late final AnimationController _pulseController;

  late final AnimationController _brandController;
  late final Animation<double> _brandFade;

  bool _showBrandScreen = false;

  @override
  void initState() {
    super.initState();

    // --- Screen 1: logo fade-in + pulse ---
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeOut);
    _logoScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // --- Screen 2: brand attribution fade-in ---
    _brandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _brandFade =
        CurvedAnimation(parent: _brandController, curve: Curves.easeIn);

    _runSequence();
  }

  Future<void> _runSequence() async {
    _logoController.forward();

    // Screen 1 total duration ~2.4s before transitioning.
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;

    setState(() => _showBrandScreen = true);
    _brandController.forward();

    // Screen 2 lasts ~1.5s.
    await Future.delayed(const Duration(milliseconds: 1500));
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
    _logoController.dispose();
    _pulseController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.navyGlow),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _showBrandScreen ? _buildBrandScreen() : _buildLogoScreen(),
        ),
      ),
    );
  }

  // Screen 1
  Widget _buildLogoScreen() {
    return Center(
      key: const ValueKey('logo-screen'),
      child: FadeTransition(
        opacity: _logoFade,
        child: ScaleTransition(
          scale: _logoScale,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final glow = 0.35 + (_pulseController.value * 0.25);
              return Container(
                padding: const EdgeInsets.all(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.redPulse(opacity: glow),
                ),
                child: child,
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/alert247_logo.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 4),
                Text(
                  'ALERT 247',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: AppColors.emergencyRed.withOpacity(0.8),
                        blurRadius: 20,
                      ),
                    ],
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
    );
  }

  // Screen 2 — "from PARM LABS" brand attribution.
  Widget _buildBrandScreen() {
    return Center(
      key: const ValueKey('brand-screen'),
      child: FadeTransition(
        opacity: _brandFade,
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
            const SizedBox(height: 10),
            const Text(
              'PARM LABS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
