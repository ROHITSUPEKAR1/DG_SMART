import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../services/dummy_data_service.dart';
import 'student_timetable.dart';

class StudentStudyScreen extends StatefulWidget {
  const StudentStudyScreen({super.key});

  @override
  State<StudentStudyScreen> createState() => _StudentStudyScreenState();
}

class _StudentStudyScreenState extends State<StudentStudyScreen> {
  int _tabIndex = 0; // 0=Homework, 1=Study Material, 2=Timetable

  @override
  Widget build(BuildContext context) {
    final homeworks = DummyDataService.homeworks;
    final pending = homeworks.where((h) => !h.isCompleted).toList();
    final completed = homeworks.where((h) => h.isCompleted).toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF5BC8F5), Color(0xFF87D4F8), Color(0xFFB0E4FA), Color(0xFFC8EDD6), Color(0xFFF5E8B0)],
          stops: [0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
      child: Column(
        children: [
          AppTopBar(title: 'Study & Homework'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: const Color(0xFFDCE6FA).withValues(alpha: 0.5), borderRadius: BorderRadius.circular(99)),
                      child: Row(
                        children: [
                          _Tab(label: '📝 Homework', isActive: _tabIndex == 0, onTap: () => setState(() => _tabIndex = 0)),
                          _Tab(label: '📂 Study Material', isActive: _tabIndex == 1, onTap: () => setState(() => _tabIndex = 1)),
                          _Tab(label: '📅 Timetable', isActive: _tabIndex == 2, onTap: () => setState(() => _tabIndex = 2)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    if (_tabIndex == 0) ...[
                      // Pending count banner
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF3b9ef5), Color(0xFF2b7de8)]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pending Tasks', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.82))),
                                  Text('${pending.length} Homework', style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                                  Text('Due this week', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.78))),
                                ],
                              ),
                            ),
                            const Text('📝', style: TextStyle(fontSize: 36)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      const SectionTitle('Pending'),
                      ...pending.map((hw) {
                        final isToday = hw.dueDate.day == 24;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(hw.title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                        Text('${hw.subject} · ${hw.teacherName}', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                                      ],
                                    ),
                                  ),
                                  isToday ? AppChip.red('Due Today') : AppChip.amber('Due: ${hw.dueDate.day} Mar'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('📎 ${hw.description}', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textLight)),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      decoration: BoxDecoration(color: isToday ? AppColors.primary : AppColors.warning, borderRadius: BorderRadius.circular(99)),
                                      child: Text(isToday ? 'Submit' : 'Upload', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),

                      const SectionTitle('Completed'),
                      ...completed.map((hw) => Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hw.title, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary, decoration: TextDecoration.lineThrough)),
                                  Text('${hw.subject} · ${hw.teacherName}', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                                ],
                              ),
                            ),
                            AppChip.green('Done'),
                          ],
                        ),
                      )),

                      const SizedBox(height: 14),
                      const SectionTitle('Recent Study Material'),
                      ..._studyMaterials(),
                    ] else if (_tabIndex == 1) ...[
                      const SectionTitle('All Study Materials'),
                      ..._studyMaterials(),
                    ] else ...[
                      // Timetable embedded
                      const StudentTimetableWidget(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _studyMaterials() {
    final materials = [
      {'icon': '📘', 'title': 'Maths – Chapter 8 Notes', 'subtitle': 'PDF · 2.4 MB', 'color': AppColors.chipBlueBg, 'action': '⬇️'},
      {'icon': '🎥', 'title': 'Science – Photosynthesis Video', 'subtitle': 'Video · 14 min', 'color': AppColors.chipGreenBg, 'action': '▶️'},
      {'icon': '📄', 'title': 'English – Grammar Worksheet', 'subtitle': 'PDF · 1.1 MB', 'color': AppColors.chipAmberBg, 'action': '⬇️'},
    ];
    return materials.map((m) => Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(color: m['color'] as Color, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(m['icon'] as String, style: const TextStyle(fontSize: 15))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['title'] as String, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                Text(m['subtitle'] as String, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
              ],
            ),
          ),
          Text(m['action'] as String, style: const TextStyle(fontSize: 14)),
        ],
      ),
    )).toList();
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(99),
            boxShadow: isActive ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.12), blurRadius: 8, offset: const Offset(0, 2))] : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: isActive ? AppColors.primaryDark : AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}
