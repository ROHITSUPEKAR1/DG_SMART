import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../models/app_models.dart';
import '../../../services/dummy_data_service.dart';


class ParentProgressScreen extends StatefulWidget {
  const ParentProgressScreen({super.key});

  @override
  State<ParentProgressScreen> createState() => _ParentProgressScreenState();
}

class _ParentProgressScreenState extends State<ParentProgressScreen> {
  int _tab = 0; // 0=Attendance, 1=Results

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFf093fb), Color(0xFFf5a623), Color(0xFFf06292), Color(0xFFe91e8c)],
        ),
      ),
      child: Column(
        children: [
          AppTopBar(title: _tab == 0 ? 'Child Attendance' : 'Results & Analytics'),
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
                          _Tab(label: '📋 Attendance', isActive: _tab == 0, onTap: () => setState(() => _tab = 0)),
                          _Tab(label: '📊 Results', isActive: _tab == 1, onTap: () => setState(() => _tab = 1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    if (_tab == 0) ...[
                      _buildAttendanceTab(),
                    ] else ...[
                      _buildResultsTab(),
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

  Widget _buildAttendanceTab() {
    final summary = DummyDataService.studentAttendanceSummary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary
        Row(
          children: [
            _StatBox(value: '${summary.present}', label: 'Present', valueColor: AppColors.chipGreenText),
            const SizedBox(width: 7),
            _StatBox(value: '${summary.absent}', label: 'Absent', valueColor: AppColors.chipRedText),
            const SizedBox(width: 7),
            _StatBox(value: '${summary.holiday}', label: 'Holiday', valueColor: AppColors.chipBlueText),
            const SizedBox(width: 7),
            _StatBox(value: '${summary.percentage.toInt()}%', label: 'Rate', valueColor: const Color(0xFFe91e63)),
          ],
        ),
        const SizedBox(height: 11),

        // Donut card
        AppCard(
          marginBottom: 11,
          child: Row(
            children: [
              SizedBox(
                width: 68, height: 68,
                child: Stack(
                  children: [
                    CustomPaint(size: const Size(68, 68), painter: _DonutPainter(summary.percentage / 100, const Color(0xFFe91e63))),
                    Center(child: Text('${summary.percentage.toInt()}%', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Attendance is good! 👍', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  const SizedBox(height: 3),
                  Text('Min required: 75%\nWell above the limit!', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted, height: 1.5)),
                  const SizedBox(height: 6),
                  AppChip.pink('On Track'),
                ],
              ),
            ],
          ),
        ),

        // Calendar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle('March 2026'),
            Row(children: ['‹', '›'].map((c) => Padding(padding: const EdgeInsets.only(left: 8), child: Text(c, style: GoogleFonts.nunito(fontSize: 14, color: AppColors.textLight)))).toList()),
          ],
        ),
        AppCard(
          marginBottom: 11,
          child: Column(
            children: [
              _buildCalendar(summary.monthlyData),
              const SizedBox(height: 8),
              Wrap(spacing: 9, children: [
                _LegendItem(color: AppColors.chipGreenBg, label: 'Present'),
                _LegendItem(color: AppColors.chipRedBg, label: 'Absent'),
                _LegendItem(color: AppColors.chipBlueBg, label: 'Holiday'),
              ]),
            ],
          ),
        ),

        // Absence alert
        const SectionTitle('Absence Alerts'),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFFFFF0F3), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFf5c4d4))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Absent on Thu, 20 March', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFFc2185b))),
                    Text('Please ensure attendance going forward. Contact teacher for details.', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFFe57399))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultsTab() {
    final result = DummyDataService.studentExamResult;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Exam selector
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _ExamChip(label: 'Unit Test 1', isActive: true),
              const SizedBox(width: 6),
              _ExamChip(label: 'Unit Test 2', isActive: false),
              const SizedBox(width: 6),
              _ExamChip(label: 'Mid-Term', isActive: false),
            ],
          ),
        ),
        const SizedBox(height: 11),

        // Overall score card
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFf093fb), Color(0xFFe91e63)]),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unit Test 1 · Overall', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                    Text('${result.avgPercentage.toInt()}%', style: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text('Class Rank: ${result.rank}rd out of 48', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                  ],
                ),
              ),
              Container(
                width: 58, height: 58,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 3), color: Colors.white.withValues(alpha: 0.15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result.grade, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text('Grade', style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white.withValues(alpha: 0.85))),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),

        // Subject breakdown
        const SectionTitle('Subject-wise Performance'),
        AppCard(
          marginBottom: 11,
          child: Column(
            children: result.subjects.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s.subject, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('${s.percentage.toInt()}%', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: s.color)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  AppProgressBar(percentage: s.percentage, fillColor: s.color, height: 6),
                ],
              ),
            )).toList(),
          ),
        ),

        // Performance alert
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFFFFF0F3), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFf5c4d4))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('📊', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Performance Alert – History', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFFc2185b))),
                    Text('Score dropped to 68%. Teacher recommends extra practice on Chapter 4–6.', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: const Color(0xFFe57399))),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),

        // Report card download
        const SectionTitle('Report Card'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('📄', style: TextStyle(fontSize: 18)))),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unit Test 1 Report Card', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text('PDF · Aryan Mehta · Class 9A', style: GoogleFonts.nunito(fontSize: 9, color: Colors.white.withValues(alpha: 0.75))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(9)),
                child: Text('⬇️ Save', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(Map<int, AttendanceStatus> data) {
    final dayHeaders = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const offset = 6;
    const totalDays = 31;

    return Column(
      children: [
        Row(children: dayHeaders.map((d) => Expanded(child: Center(child: Text(d, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.textLight))))).toList()),
        const SizedBox(height: 6),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 3, mainAxisSpacing: 3),
          itemCount: offset + totalDays,
          itemBuilder: (_, index) {
            if (index < offset) return const SizedBox();
            final day = index - offset + 1;
            final status = data[day];
            Color? bg;
            Color textColor = const Color(0xFF8899bb);
            bool isToday = day == 24;

            if (status == AttendanceStatus.present) { bg = AppColors.chipGreenBg; textColor = AppColors.chipGreenText; }
            else if (status == AttendanceStatus.absent) { bg = AppColors.chipRedBg; textColor = AppColors.chipRedText; }
            else if (status == AttendanceStatus.holiday) { bg = AppColors.chipBlueBg; textColor = AppColors.chipBlueText; }

            return Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(7),
                border: isToday ? Border.all(color: const Color(0xFFe91e63), width: 2) : null,
              ),
              child: Center(
                child: Text('$day', style: GoogleFonts.nunito(fontSize: 9, fontWeight: isToday ? FontWeight.w900 : FontWeight.w700, color: isToday ? const Color(0xFFe91e63) : textColor)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  const _StatBox({required this.value, required this.label, required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w900, color: valueColor)),
            Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }
}

class _ExamChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _ExamChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFe91e63) : Colors.white,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: isActive ? const Color(0xFFe91e63) : AppColors.border),
      ),
      child: Text(label, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: isActive ? Colors.white : AppColors.textMuted)),
    );
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
          decoration: BoxDecoration(color: isActive ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(99)),
          child: Text(label, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w900, color: isActive ? const Color(0xFFe91e63) : AppColors.textMuted)),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percentage;
  final Color color;
  _DonutPainter(this.percentage, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 8.0;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    paint.color = AppColors.borderLight;
    canvas.drawCircle(center, radius, paint);
    paint.color = color;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -1.5707963, 2 * 3.14159 * percentage, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 3),
        Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textLight)),
      ],
    );
  }
}
