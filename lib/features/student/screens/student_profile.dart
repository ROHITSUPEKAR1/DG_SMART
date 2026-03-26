import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import '../../auth/screens/login_screen.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = DummyDataService.students.first;
    final result = DummyDataService.studentExamResult;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero header
          Container(
            padding: const EdgeInsets.fromLTRB(18, 44, 18, 44),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5BC8F5), Color(0xFF87D4F8), Color(0xFFb0e8c8), Color(0xFFC8EDD6)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(top: 0, left: 10, child: Opacity(opacity: 0.65, child: Text('📚', style: TextStyle(fontSize: 18)))),
                Positioned(top: 0, right: 12, child: Opacity(opacity: 0.65, child: Text('💡', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 10, left: 8, child: Opacity(opacity: 0.65, child: Text('✏️', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 6, right: 10, child: Opacity(opacity: 0.65, child: Text('🔭', style: TextStyle(fontSize: 18)))),
                Column(
                  children: [
                    // back + title + edit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(onTap: () {}, child: Container(width: 32, height: 32, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.35)), child: const Center(child: Text('‹', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white))))),
                        Text('My Profile', style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)),
                        Container(width: 32, height: 32, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.35)), child: const Center(child: Text('✏️', style: TextStyle(fontSize: 13)))),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: 68, height: 68,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.28), border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 3)),
                      child: Center(child: Text(student.initials, style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white))),
                    ),
                    const SizedBox(height: 10),
                    Text(student.name, style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 3),
                    Text('Class ${student.fullClass} · Roll No. ${student.rollNo.split('-').last}', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.82))),
                  ],
                ),
              ],
            ),
          ),

          // Floating stats
          Transform.translate(
            offset: const Offset(0, -22),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [BoxShadow(color: const Color(0x173C78DC), blurRadius: 18, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    _StatCell(value: '${student.attendance.toInt()}%', label: 'Attendance', color: AppColors.primary),
                    _StatCell(value: '${student.avgScore.toInt()}%', label: 'Avg Score', color: AppColors.primary),
                    _StatCell(value: '${student.activities}', label: 'Activities', color: AppColors.success),
                    _StatCell(value: '${student.classRank}${student.classRank == 1 ? 'st' : student.classRank == 2 ? 'nd' : student.classRank == 3 ? 'rd' : 'th'}', label: 'Class Rank', color: AppColors.warning, isLast: true),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Personal Info'),
                AppCard(
                  marginBottom: 12,
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
                  child: Column(
                    children: [
                      InfoRow(icon: '📞', label: 'Parent Phone', value: student.parentPhone),
                      InfoRow(icon: '✉️', label: 'Email', value: student.email),
                      InfoRow(icon: '🎂', label: 'Date of Birth', value: student.dob),
                      InfoRow(icon: '🏠', label: 'Address', value: student.address),
                      InfoRow(icon: '🆔', label: 'Admission No.', value: student.admissionNo),
                      InfoRow(icon: '🏫', label: 'Class Teacher', value: student.classTeacher, showBorder: false),
                    ],
                  ),
                ),

                const SectionTitle('Subject Performance'),
                AppCard(
                  marginBottom: 12,
                  child: Column(
                    children: result.subjects.map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(s.subject, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: s.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(99)),
                                child: Text('${s.percentage.toInt()}%', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: s.color)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          AppProgressBar(percentage: s.percentage, fillColor: s.color),
                        ],
                      ),
                    )).toList(),
                  ),
                ),

                GradientButton(
                  label: 'Log Out',
                  colors: const [Color(0xFF3b9ef5), Color(0xFF2b7de8)],
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
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: isLast ? null : BoxDecoration(border: Border(right: BorderSide(color: AppColors.borderLight))),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
            const SizedBox(height: 2),
            Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textLight), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
