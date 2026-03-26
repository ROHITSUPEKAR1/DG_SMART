import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import 'parent_progress.dart';
import 'parent_fees.dart';
import 'parent_profile.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  int _navIndex = 0;

  final _navItems = const [
    BottomNavItem(icon: '🏠', label: 'Home'),
    BottomNavItem(icon: '📊', label: 'Progress'),
    BottomNavItem(icon: '💰', label: 'Fees'),
    BottomNavItem(icon: '👤', label: 'Profile'),
  ];

  Widget _getScreen() {
    switch (_navIndex) {
      case 1: return const ParentProgressScreen();
      case 2: return const ParentFeesScreen();
      case 3: return const ParentProfileScreen();
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
          // Parent header – pink/red gradient
          Container(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 26),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFf093fb), Color(0xFFf5a623), Color(0xFFf06292), Color(0xFFe91e8c)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(top: 0, right: 12, child: Opacity(opacity: 0.2, child: Text('💖', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 0, right: 10, child: Opacity(opacity: 0.18, child: Text('⭐', style: TextStyle(fontSize: 18)))),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome back 👋', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.82))),
                            Text(auth.currentUser?.name ?? 'Mrs. Sunita Mehta', style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
                            Text('Parent of ${student.name} · Class ${student.fullClass}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.75))),
                          ],
                        ),
                      ),
                      Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.25), border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2)),
                        child: Center(child: Text(auth.currentUser?.avatarInitials ?? 'SM', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Child card
          Transform.translate(
            offset: const Offset(0, -16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [BoxShadow(color: const Color(0xFFe91e63).withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AvatarCircle(
                          initials: student.initials,
                          size: 40,
                          gradient: const [Color(0xFFf093fb), Color(0xFFe91e63)],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(student.name, style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                              Text('Class ${student.fullClass} · Roll No. ${student.rollNo.split('-').last} · ${student.admissionNo}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textLight)),
                            ],
                          ),
                        ),
                        AppChip.green('Active'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _MiniStat(value: '${student.attendance.toInt()}%', label: 'Attendance', color: AppColors.primary),
                        _MiniStat(value: '${student.avgScore.toInt()}%', label: 'Avg Score', color: AppColors.success),
                        _MiniStat(value: '2', label: 'HW Due', color: AppColors.warning),
                        _MiniStat(value: '${student.classRank}rd', label: 'Rank', color: const Color(0xFFe91e63), isLast: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Quick Access'),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  childAspectRatio: 1.7,
                  padding: const EdgeInsets.only(bottom: 14),
                  children: [
                    _ParentQuickCard(icon: '📋', title: 'Attendance', subtitle: '${student.attendance.toInt()}% this month', color: AppColors.chipRedBg, textColor: AppColors.chipRedText, onTap: () => setState(() => _navIndex = 1)),
                    _ParentQuickCard(icon: '📊', title: 'Results', subtitle: 'Avg: ${student.avgScore.toInt()}%', color: AppColors.chipBlueBg, textColor: AppColors.chipBlueText, onTap: () => setState(() => _navIndex = 1)),
                    _ParentQuickCard(icon: '💰', title: 'Fee Status', subtitle: 'All Paid ✓', color: AppColors.chipGreenBg, textColor: AppColors.chipGreenText, onTap: () => setState(() => _navIndex = 2)),
                    _ParentQuickCard(icon: '📅', title: 'Timetable', subtitle: '3 classes today', color: AppColors.chipAmberBg, textColor: AppColors.chipAmberText, onTap: () {}),
                  ],
                ),

                const SectionTitle('Latest Notices'),
                ...notices.map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(width: 7, height: 7, decoration: BoxDecoration(shape: BoxShape.circle, color: n.dotColor)),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: n != notices.last ? BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderLight))) : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              Text(n.description, style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                            ],
                          ),
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
        activeColor: const Color(0xFFe91e63),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool isLast;

  const _MiniStat({required this.value, required this.label, required this.color, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(9),
          border: isLast ? null : Border(right: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        margin: EdgeInsets.only(right: isLast ? 0 : 4),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
            Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textLight), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ParentQuickCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _ParentQuickCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(icon, style: const TextStyle(fontSize: 17)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: textColor)),
                Text(subtitle, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w700, color: textColor.withValues(alpha: 0.75))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
