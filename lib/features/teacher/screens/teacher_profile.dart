import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import '../../auth/screens/login_screen.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = DummyDataService.teachers[1]; // Sneha Desai
    final leaves = DummyDataService.teacherLeaveHistory;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(13, 44, 13, 50),
            child: Stack(
              children: [
                Positioned(top: 0, right: 12, child: Opacity(opacity: 0.2, child: Text('📚', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 10, right: 8, child: Opacity(opacity: 0.18, child: Text('✏️', style: TextStyle(fontSize: 18)))),
                Column(
                  children: [
                    // Floating stats card
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.25), border: Border.all(color: Colors.white.withValues(alpha: 0.65), width: 3)),
                            child: Center(child: Text(teacher.initials, style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white))),
                          ),
                          const SizedBox(height: 8),
                          Text(teacher.name, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                          Text('${teacher.subject} Teacher · ${teacher.employeeId}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.8))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Floating stats
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [BoxShadow(color: const Color(0xFF764ba2).withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          _StatCell(value: '${teacher.attendance.toInt()}%', label: 'Attendance', color: const Color(0xFF764ba2)),
                          _StatCell(value: '138', label: 'Students', color: AppColors.success),
                          _StatCell(value: '${teacher.classes.length}', label: 'Classes', color: AppColors.primary),
                          _StatCell(value: '${teacher.experience} yrs', label: 'Experience', color: AppColors.warning, isLast: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 16, 13, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Personal Info'),
                AppCard(
                  marginBottom: 10,
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                  child: Column(
                    children: [
                      InfoRow(icon: '📞', label: 'Phone', value: teacher.phone),
                      InfoRow(icon: '✉️', label: 'Email', value: teacher.email),
                      InfoRow(icon: '🎓', label: 'Qualification', value: teacher.qualification),
                      InfoRow(icon: '🏫', label: 'Subjects', value: '${teacher.subject} (${teacher.classes.join(',')})', showBorder: false),
                    ],
                  ),
                ),

                // Apply for leave
                const SectionTitle('Apply for Leave'),
                AppCard(
                  marginBottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave Type', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text('Medical Leave', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                const SizedBox(height: 4),
                                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)), child: Text('28 Mar 2026', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('To', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                const SizedBox(height: 4),
                                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)), child: Text('29 Mar 2026', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Reason', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Container(
                        height: 50, padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text('Medical checkup...', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                      ),
                      const SizedBox(height: 10),
                      GradientButton(
                        label: '📋 Submit Leave Request',
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request submitted!'))),
                        colors: const [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                    ],
                  ),
                ),

                // Leave history
                const SectionTitle('Leave History'),
                ...leaves.map((l) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l.leaveType, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          Text('${l.fromDate.day}–${l.toDate.day} ${_month(l.fromDate.month)} 2026 · ${l.days} day${l.days > 1 ? 's' : ''}', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                        ],
                      ),
                      l.status.name == 'pending' ? AppChip.amber('Pending') : AppChip.green('Approved'),
                    ],
                  ),
                )),
                const SizedBox(height: 4),

                // Logout
                GradientButton(
                  label: 'Log Out',
                  colors: const [Color(0xFFc83a3a), Color(0xFFa02020)],
                  onTap: () async {
                    await context.read<AuthProvider>().logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _month(int m) {
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[m];
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool isLast;

  const _StatCell({required this.value, required this.label, required this.color, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: isLast ? null : BoxDecoration(border: Border(right: BorderSide(color: AppColors.borderLight))),
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
