import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    final auth = context.read<AuthProvider>();
    await auth.autoLogin();
    if (!mounted) return;
    if (auth.isLoggedIn) {
      _navigate(auth.currentRole);
    }
  }

  void _navigate(dynamic role) {
    // Navigate after splash – if auto-logged in, skip to appropriate home
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5BC8F5), Color(0xFF87D4F8),
              Color(0xFFB0E4FA), Color(0xFFC8EDD6), Color(0xFFF5E8B0),
            ],
            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Floating emoji decorations
              ..._buildFloatingIcons(),
              // Main content
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white.withValues(alpha: 0.3),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                        ),
                        child: const Center(child: Text('🎓', style: TextStyle(fontSize: 36))),
                      ),
                      const SizedBox(height: 18),
                      Text('Welcome to', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                      const SizedBox(height: 4),
                      Text('DG Smart', style: GoogleFonts.nunito(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, shadows: [Shadow(color: Colors.blue.withValues(alpha: 0.18), offset: const Offset(0, 2), blurRadius: 8)])),
                      const SizedBox(height: 6),
                      Text('Your School in Your Pocket', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.8))),
                      const SizedBox(height: 50),
                      // Enquiry button
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text('Get Started', textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.76),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text('Sign In', textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFF1a2a4a))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingIcons() {
    final icons = [
      {'icon': '📚', 'top': 40.0, 'left': 20.0},
      {'icon': '💡', 'top': 35.0, 'right': 24.0},
      {'icon': '🎓', 'top': 35.0, 'right': 70.0},
      {'icon': '📒', 'top': 110.0, 'left': 12.0},
      {'icon': '✏️', 'top': 100.0, 'right': 12.0},
      {'icon': '🔭', 'top': 190.0, 'right': 14.0},
      {'icon': '🌍', 'bottom': 220.0, 'left': 12.0},
      {'icon': '⚗️', 'bottom': 140.0, 'right': 14.0},
      {'icon': '🎓', 'bottom': 80.0, 'left': 20.0},
      {'icon': '💡', 'bottom': 60.0, 'right': 28.0},
      {'icon': '📐', 'top': 300.0, 'left': 8.0},
    ];

    return icons.map((item) {
      return Positioned(
        top: item['top'] as double?,
        left: item['left'] as double?,
        right: item['right'] as double?,
        bottom: item['bottom'] as double?,
        child: Opacity(
          opacity: 0.72,
          child: Text(item['icon'] as String, style: const TextStyle(fontSize: 20)),
        ),
      );
    }).toList();
  }
}
