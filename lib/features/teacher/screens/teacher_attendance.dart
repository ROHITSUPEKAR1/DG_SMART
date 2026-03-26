import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../services/dummy_data_service.dart';
import 'teacher_marks.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  int _classIndex = 0;
  final _classes = ['Class 9A', 'Class 8A', 'Class 9B'];
  late List<Map<String, dynamic>> _students;
  int _tab = 0; // 0=Attendance, 1=Marks Entry

  @override
  void initState() {
    super.initState();
    _students = DummyDataService.classStudentsAttendance
        .map((s) => Map<String, dynamic>.from(s))
        .toList();
  }

  void _toggleStatus(int index) {
    setState(() {
      final current = _students[index]['status'] as String;
      if (current == 'P') _students[index]['status'] = 'A';
      else if (current == 'A') _students[index]['status'] = 'L';
      else _students[index]['status'] = 'P';
    });
  }

  int get _present => _students.where((s) => s['status'] == 'P').length;
  int get _absent => _students.where((s) => s['status'] == 'A').length;
  int get _late => _students.where((s) => s['status'] == 'L').length;

  @override
  Widget build(BuildContext context) {
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
          AppTopBar(title: _tab == 0 ? 'Mark Attendance' : 'Marks Entry'),
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
                    // Tab
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: const Color(0xFFDCE6FA).withValues(alpha: 0.5), borderRadius: BorderRadius.circular(99)),
                      child: Row(
                        children: [
                          _Tab(label: '📋 Attendance', isActive: _tab == 0, activeColor: const Color(0xFF764ba2), onTap: () => setState(() => _tab = 0)),
                          _Tab(label: '📊 Marks Entry', isActive: _tab == 1, activeColor: const Color(0xFF764ba2), onTap: () => setState(() => _tab = 1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Class selector
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _classes.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () => setState(() => _classIndex = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _classIndex == i ? const Color(0xFF764ba2) : Colors.white,
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(color: _classIndex == i ? const Color(0xFF764ba2) : AppColors.border),
                            ),
                            child: Text(_classes[i], style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: _classIndex == i ? Colors.white : AppColors.textMuted)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),

                    if (_tab == 0) ...[
                      // Date card
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tuesday, 24 March 2026', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                                Text('Science · Period 1 · 9:00 AM', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                              ],
                            ),
                            AppChip.green('48 Students'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 11),

                      // Summary pills
                      Row(
                        children: [
                          _SummaryPill(value: _present, label: 'Present', bgColor: AppColors.chipGreenBg, textColor: AppColors.chipGreenText),
                          const SizedBox(width: 6),
                          _SummaryPill(value: _absent, label: 'Absent', bgColor: AppColors.chipRedBg, textColor: AppColors.chipRedText),
                          const SizedBox(width: 6),
                          _SummaryPill(value: _late, label: 'Late', bgColor: AppColors.chipAmberBg, textColor: AppColors.chipAmberText),
                          const SizedBox(width: 6),
                          _SummaryPill(value: 0, label: 'Leave', bgColor: AppColors.chipBlueBg, textColor: AppColors.chipBlueText),
                        ],
                      ),
                      const SizedBox(height: 11),

                      const SectionTitle('Students (Tap to toggle)'),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 0.8,
                        ),
                        itemCount: _students.length,
                        itemBuilder: (_, i) {
                          final s = _students[i];
                          final status = s['status'] as String;
                          Color bg = AppColors.chipGreenBg;
                          Color badgeBg = AppColors.success;
                          if (status == 'A') { bg = AppColors.chipRedBg; badgeBg = AppColors.error; }
                          else if (status == 'L') { bg = AppColors.chipAmberBg; badgeBg = AppColors.warning; }

                          return GestureDetector(
                            onTap: () => _toggleStatus(i),
                            child: Container(
                              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 22, height: 22,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: badgeBg),
                                    child: Center(child: Text(status, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white))),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    s['name'] as String,
                                    style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text('Showing ${_students.length} of 48 students', textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                      const SizedBox(height: 10),
                      GradientButton(
                        label: '✓ Submit Attendance',
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance submitted successfully!'))),
                        colors: const [Color(0xFF667eea), Color(0xFF764ba2)],
                      ),
                    ] else ...[
                      const TeacherMarksWidget(),
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
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _Tab({required this.label, required this.isActive, required this.activeColor, required this.onTap});

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
          ),
          child: Text(label, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: isActive ? activeColor : AppColors.textMuted)),
        ),
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  final int value;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _SummaryPill({required this.value, required this.label, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text('$value', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w900, color: textColor)),
            Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: textColor.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }
}
