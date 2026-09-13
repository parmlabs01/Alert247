import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

// NOTE: Firebase / Supabase initialization goes here once you add your own
// project credentials. See README.md for setup steps, e.g.:
//
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Supabase.initialize(url: 'YOUR_SUPABASE_URL', anonKey: 'YOUR_ANON_KEY');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Alert247App());
}

class Alert247App extends StatelessWidget {
  const Alert247App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert 247',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
