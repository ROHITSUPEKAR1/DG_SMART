import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import 'student_attendance.dart';
import 'student_profile.dart';
import 'student_study.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _navIndex = 0;

  final _navItems = const [
    BottomNavItem(icon: '🏠', label: 'Home'),
    BottomNavItem(icon: '📋', label: 'Attend'),
    BottomNavItem(icon: '👤', label: 'Profile'),
    BottomNavItem(icon: '📚', label: 'Study'),
  ];

  Widget _getScreen() {
    switch (_navIndex) {
      case 1: return const StudentAttendanceScreen();
      case 2: return const StudentProfileScreen();
      case 3: return const StudentStudyScreen();
      default: return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    final auth = context.watch<AuthProvider>();
    final student = DummyDataService.students.first;
    final notices = DummyDataService.notices.take(3).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5BC8F5), Color(0xFF87D4F8), Color(0xFFb0e8c8)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
            child: Stack(
              children: [
                Positioned(top: 0, right: 14, child: Opacity(opacity: 0.28, child: Text('📚', style: TextStyle(fontSize: 20)))),
                Positioned(bottom: 0, right: 10, child: Opacity(opacity: 0.22, child: Text('💡', style: TextStyle(fontSize: 20)))),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good Morning ☀️', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                            Text(auth.currentUser?.name ?? student.name, style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                            Text('Class ${student.fullClass}', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.8))),
                          ],
                        ),
                      ),
                      Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.3),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.55), width: 2),
                        ),
                        child: Center(child: Text(student.initials, style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            margin: const EdgeInsets.only(top: -16),
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Quick Access'),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.6,
                  padding: const EdgeInsets.only(bottom: 14),
                  children: [
                    _QuickCard(icon: '📋', title: 'Attendance', subtitle: '${student.attendance.toInt()}% this month', color: AppColors.chipGreenBg, textColor: AppColors.chipGreenText, onTap: () => setState(() => _navIndex = 1)),
                    _QuickCard(icon: '📝', title: 'Homework', subtitle: '2 pending', color: AppColors.chipBlueBg, textColor: AppColors.chipBlueText, onTap: () => setState(() => _navIndex = 3)),
                    _QuickCard(icon: '📅', title: 'Timetable', subtitle: '3 classes today', color: AppColors.chipAmberBg, textColor: AppColors.chipAmberText, onTap: () => setState(() => _navIndex = 3)),
                    _QuickCard(icon: '📊', title: 'Results', subtitle: 'Last exam: ${student.avgScore.toInt()}%', color: AppColors.chipRedBg, textColor: AppColors.chipRedText, onTap: () => setState(() => _navIndex = 2)),
                  ],
                ),
                const SectionTitle('Latest Notices'),
                ...notices.map((n) => Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Text(n.icon, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 1.3)),
                            Text(n.description, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
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
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _QuickCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: textColor)),
                Text(subtitle, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: textColor.withValues(alpha: 0.75))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
