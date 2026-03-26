import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/dummy_data_service.dart';
import '../../auth/screens/login_screen.dart';

class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  int _selectedTime = 0;
  final _times = ['10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM'];

  @override
  Widget build(BuildContext context) {
    final student = DummyDataService.students.first;
    final meetings = DummyDataService.meetings;
    final auth = context.watch<AuthProvider>();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFf093fb), Color(0xFFe91e63)],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(13, 44, 13, 44),
            child: Stack(
              children: [
                Positioned(top: 0, right: 12, child: Opacity(opacity: 0.2, child: Text('💖', style: TextStyle(fontSize: 18)))),
                Positioned(bottom: 12, right: 8, child: Opacity(opacity: 0.18, child: Text('⭐', style: TextStyle(fontSize: 18)))),
                Column(
                  children: [
                    AvatarCircle(
                      initials: auth.currentUser?.avatarInitials ?? 'SM',
                      size: 58,
                      gradient: const [Colors.white],
                      textColor: const Color(0xFFe91e63),
                    ),
                    const SizedBox(height: 8),
                    Text(auth.currentUser?.name ?? 'Mrs. Sunita Mehta', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text('Parent · ${student.name} – ${student.fullClass}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(13, 14, 13, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book meeting
                const SectionTitle('Book Parent-Teacher Meeting'),
                AppCard(
                  marginBottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Teacher', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text('Mrs. S. Desai (Science)', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ),
                      const SizedBox(height: 8),
                      Text('Preferred Date', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text('30 March 2026', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ),
                      const SizedBox(height: 8),
                      Text('Preferred Time', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: List.generate(_times.length, (i) => GestureDetector(
                          onTap: () => setState(() => _selectedTime = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: _selectedTime == i ? const Color(0xFFe91e63) : Colors.white,
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: _selectedTime == i ? const Color(0xFFe91e63) : AppColors.border),
                            ),
                            child: Text(_times[i], style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: _selectedTime == i ? Colors.white : AppColors.textMuted)),
                          ),
                        )),
                      ),
                      const SizedBox(height: 8),
                      Text('Message (Optional)', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                        child: Text("I'd like to discuss Aryan's History performance...", style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                      ),
                      const SizedBox(height: 10),
                      GradientButton(
                        label: '📅 Book Meeting',
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meeting request sent!'))),
                        colors: const [Color(0xFFf06292), Color(0xFFe91e63)],
                      ),
                    ],
                  ),
                ),

                // Upcoming meetings
                const SectionTitle('Upcoming Meetings'),
                ...meetings.map((m) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38, height: 38,
                        child: Column(
                          children: [
                            Text('${m.date.day}', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: const Color(0xFFe91e63))),
                            Text(_month(m.date.month), style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textLight)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${m.teacherName} – ${m.subject}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                            Text('${m.time} · ${m.room}', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                            const SizedBox(height: 4),
                            AppChip.pink('Confirmed', fontSize: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 4),

                // Behaviour report
                const SectionTitle('Behaviour Report – March'),
                AppCard(
                  marginBottom: 10,
                  child: Column(
                    children: [
                      ...[
                        {'label': 'Participation', 'chip': 'Excellent', 'type': 'green'},
                        {'label': 'Discipline', 'chip': 'Very Good', 'type': 'green'},
                        {'label': 'Homework Completion', 'chip': 'Good', 'type': 'amber'},
                        {'label': 'Teamwork', 'chip': 'Excellent', 'type': 'green'},
                      ].map((b) => Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(b['label'] as String, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            b['type'] == 'green' ? AppChip.green(b['chip'] as String, fontSize: 9) : AppChip.amber(b['chip'] as String, fontSize: 9),
                          ],
                        ),
                      )),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(color: const Color(0xFFF8F4FF), borderRadius: BorderRadius.circular(8)),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: '💬 "Aryan is a bright and enthusiastic student. Needs to focus more on History revision."\n', style: GoogleFonts.nunito(fontSize: 9, color: const Color(0xFF7b5edb), fontStyle: FontStyle.italic, height: 1.5)),
                            TextSpan(text: '— Mrs. Patil, Class Teacher', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),

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
    const months = ['', 'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[m];
  }
}
