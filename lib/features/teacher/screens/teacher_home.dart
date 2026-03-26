import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import 'teacher_attendance.dart';
import 'teacher_homework.dart';
import 'teacher_profile.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  int _navIndex = 0;

  final _navItems = const [
    BottomNavItem(icon: '🏠', label: 'Home'),
    BottomNavItem(icon: '📋', label: 'Classes'),
    BottomNavItem(icon: '📝', label: 'Homework'),
    BottomNavItem(icon: '👤', label: 'Profile'),
  ];

  Widget _getScreen() {
    switch (_navIndex) {
      case 1: return const TeacherAttendanceScreen();
      case 2: return const TeacherHomeworkScreen();
      case 3: return const TeacherProfileScreen();
      default: return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    final auth = context.watch<AuthProvider>();
    final classes = DummyDataService.teacherTodayClasses;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Teacher header – purple gradient
          Container(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 26),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(top: 0, right: 12, child: Opacity(opacity: 0.22, child: Text('🎓', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 0, right: 10, child: Opacity(opacity: 0.18, child: Text('📚', style: TextStyle(fontSize: 18)))),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good Morning ☀️', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.8))),
                            Text(auth.currentUser?.name ?? 'Mrs. Sneha Desai', style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
                            Text('Science Dept. · 3 Classes Today', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.75))),
                          ],
                        ),
                      ),
                      Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.25), border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2)),
                        child: Center(child: Text(auth.currentUser?.avatarInitials ?? 'SD', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stat row
          Transform.translate(
            offset: const Offset(0, -14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                children: [
                  _TeacherStatBox(value: '3', label: 'Classes Today', color: const Color(0xFF764ba2)),
                  const SizedBox(width: 7),
                  _TeacherStatBox(value: '138', label: 'Total Students', color: AppColors.success),
                  const SizedBox(width: 7),
                  _TeacherStatBox(value: '4', label: 'HW Pending', color: AppColors.warning),
                  const SizedBox(width: 7),
                  _TeacherStatBox(value: '91%', label: 'Avg Attend.', color: AppColors.primary),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle("Today's Classes"),
                ...classes.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: c['bgColor'] as Color, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.55), borderRadius: BorderRadius.circular(8)),
                        child: Center(child: Text(c['icon'] as String, style: const TextStyle(fontSize: 13))),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${c['subject']} – ${c['class']}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: c['textColor'] as Color)),
                            Text('${c['time']} · ${c['room']}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: (c['textColor'] as Color).withValues(alpha: 0.8))),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(99)),
                        child: Text(c['status'] as String, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: c['textColor'] as Color)),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: 4),
                const SectionTitle('Quick Actions'),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  childAspectRatio: 2.0,
                  children: [
                    _QuickAction(icon: '📋', label: 'Mark Attendance', onTap: () => setState(() => _navIndex = 1)),
                    _QuickAction(icon: '📤', label: 'Upload Homework', onTap: () => setState(() => _navIndex = 2)),
                    _QuickAction(icon: '📊', label: 'Enter Marks', onTap: () => setState(() => _navIndex = 1)),
                    _QuickAction(icon: '📅', label: 'Timetable', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _getScreen()),
      bottomNavigationBar: AppBottomNav(
        items: _navItems,
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        activeColor: const Color(0xFF764ba2),
      ),
    );
  }
}

class _TeacherStatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _TeacherStatBox({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), boxShadow: [BoxShadow(color: const Color(0xFF764ba2).withValues(alpha: 0.08), blurRadius: 10)]),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
            Text(label, style: GoogleFonts.nunito(fontSize: 7, fontWeight: FontWeight.w800, color: AppColors.textLight), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Flexible(child: Text(label, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textPrimary))),
          ],
        ),
      ),
    );
  }
}
