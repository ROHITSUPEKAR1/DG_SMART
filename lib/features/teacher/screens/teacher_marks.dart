import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../services/dummy_data_service.dart';

class TeacherMarksWidget extends StatefulWidget {
  const TeacherMarksWidget({super.key});

  @override
  State<TeacherMarksWidget> createState() => _TeacherMarksWidgetState();
}

class _TeacherMarksWidgetState extends State<TeacherMarksWidget> {
  @override
  Widget build(BuildContext context) {
    final marks = DummyDataService.marksEntryList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                child: Text('Unit Test – Term 2', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(9)),
                child: Text('Class 9A', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.chipPurpleBg, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Science · Unit Test', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.chipPurpleText)),
                  Text('Max Marks: 50 · Class 9A', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.chipPurpleText.withValues(alpha: 0.8))),
                ],
              ),
              AppChip.purple('42 entered'),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Marks table
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(14))),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('STUDENT', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.textMuted))),
                    Expanded(flex: 2, child: Text('MARKS /50', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.textMuted), textAlign: TextAlign.center)),
                    Expanded(flex: 1, child: Text('GRADE', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.textMuted), textAlign: TextAlign.center)),
                  ],
                ),
              ),
              ...marks.asMap().entries.map((e) {
                final i = e.key;
                final m = e.value;
                final isLast = i == marks.length - 1;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(m['name'] as String, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.background, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(6)),
                            child: Text('${m['marks']}', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: m['color'] as Color), textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: AppChip.green(m['grade'] as String),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GradientButton(
          label: '✓ Save & Submit Marks',
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marks submitted successfully!'))),
          colors: const [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ],
    );
  }
}
