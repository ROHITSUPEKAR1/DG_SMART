import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../services/dummy_data_service.dart';

class TeacherHomeworkScreen extends StatelessWidget {
  const TeacherHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeworks = DummyDataService.teacherHomeworks;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFf093fb), Color(0xFFf5a623)],
        ),
      ),
      child: Column(
        children: [
          AppTopBar(title: 'Homework & Study'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(13, 16, 13, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upload form
                    const SectionTitle('Upload New Homework'),
                    AppCard(
                      marginBottom: 11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Subject & Class *', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(child: _SelectBox(label: 'Science')),
                              const SizedBox(width: 6),
                              Expanded(child: _SelectBox(label: 'Class 9A')),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Title *', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                            child: Text('Chapter 7 – Chemical Reactions...', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                          ),
                          const SizedBox(height: 8),
                          Text('Description', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          const SizedBox(height: 4),
                          Container(
                            height: 55,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                            child: Text('Solve exercise 7.2, Q1 to Q8...', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                          ),
                          const SizedBox(height: 8),
                          Text('Due Date *', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                            child: Text('26 March 2026', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border, style: BorderStyle.solid), borderRadius: BorderRadius.circular(9)),
                              child: Column(
                                children: [
                                  const Text('📎', style: TextStyle(fontSize: 16)),
                                  const SizedBox(height: 3),
                                  Text('Attach File (Optional)', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                                  Text('PDF / Image · Max 10MB', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GradientButton(
                            label: '📤 Upload Homework',
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Homework uploaded!'))),
                            colors: const [Color(0xFF667eea), Color(0xFF764ba2)],
                          ),
                        ],
                      ),
                    ),

                    // Recent uploads
                    const SectionTitle('Recent Uploads'),
                    ...homeworks.take(2).map((hw) {
                      final progress = (hw.submittedCount ?? 0) / (hw.totalCount ?? 1);
                      final isLow = progress < 0.5;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(hw.title, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                      Text('${hw.subject} · ${hw.className} · Due: ${hw.dueDate.day} Mar', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(color: isLow ? AppColors.chipAmberBg : AppColors.chipPurpleBg, borderRadius: BorderRadius.circular(99)),
                                  child: Text('${hw.submittedCount}/${hw.totalCount} done', style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: isLow ? AppColors.chipAmberText : AppColors.chipPurpleText)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.borderLight,
                                valueColor: AlwaysStoppedAnimation(isLow ? AppColors.warning : const Color(0xFF764ba2)),
                                minHeight: 5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    // Study material
                    const SectionTitle('Study Material'),
                    ...[
                      {'icon': '📘', 'title': 'Chapter 8 Notes – PDF', 'sub': 'Science · 2.4 MB', 'color': AppColors.chipBlueBg, 'chip': 'Published', 'chipType': 'blue'},
                      {'icon': '🎥', 'title': 'Photosynthesis Video', 'sub': 'Science · 14 min', 'color': AppColors.chipGreenBg, 'chip': 'Published', 'chipType': 'green'},
                    ].map((m) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                      child: Row(
                        children: [
                          Container(width: 30, height: 30, decoration: BoxDecoration(color: m['color'] as Color, borderRadius: BorderRadius.circular(9)), child: Center(child: Text(m['icon'] as String, style: const TextStyle(fontSize: 14)))),
                          const SizedBox(width: 9),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(m['title'] as String, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                            Text(m['sub'] as String, style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                          ])),
                          m['chipType'] == 'blue' ? AppChip.blue('Published', fontSize: 8) : AppChip.green('Published', fontSize: 8),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  final String label;
  const _SelectBox({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
      child: Text(label, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
    );
  }
}
