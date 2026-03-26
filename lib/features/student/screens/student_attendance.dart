import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../models/app_models.dart';
import '../../../services/dummy_data_service.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final summary = DummyDataService.studentAttendanceSummary;
    final records = DummyDataService.recentAttendance;

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
          AppTopBar(title: 'My Attendance'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary stats
                    Row(
                      children: [
                        _StatBox(value: '${summary.present}', label: 'Present', valueColor: AppColors.chipGreenText),
                        const SizedBox(width: 8),
                        _StatBox(value: '${summary.absent}', label: 'Absent', valueColor: AppColors.chipRedText),
                        const SizedBox(width: 8),
                        _StatBox(value: '${summary.holiday}', label: 'Holiday', valueColor: AppColors.chipBlueText),
                        const SizedBox(width: 8),
                        _StatBox(value: '${summary.percentage.toInt()}%', label: 'Rate', valueColor: AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Donut chart / overall status
                    const SectionTitle('Overall Status'),
                    AppCard(
                      marginBottom: 12,
                      child: Row(
                        children: [
                          _DonutChart(percentage: summary.percentage / 100),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Attendance is good!', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                              const SizedBox(height: 4),
                              Text('Min required: 75%\nWell above the limit!', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, height: 1.5)),
                              const SizedBox(height: 7),
                              AppChip.green('On Track', fontSize: 9),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Calendar
                    const SectionTitle('March 2026'),
                    AppCard(
                      marginBottom: 12,
                      child: Column(
                        children: [
                          _buildCalendar(summary.monthlyData),
                          const SizedBox(height: 9),
                          _buildCalendarLegend(),
                        ],
                      ),
                    ),

                    // Recent log
                    const SectionTitle('Recent Log'),
                    AppCard(
                      padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
                      child: Column(
                        children: records.asMap().entries.map((e) {
                          final record = e.value;
                          final isLast = e.key == records.length - 1;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderLight))),
                            child: Row(
                              children: [
                                Container(
                                  width: 7, height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: record.status == AttendanceStatus.present ? AppColors.success : AppColors.error,
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_formatDate(record.date), style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                      Text(record.checkInTime ?? 'No check-in', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                                    ],
                                  ),
                                ),
                                record.status == AttendanceStatus.present
                                    ? AppChip.green('Present', fontSize: 9)
                                    : AppChip.red('Absent', fontSize: 9),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';
  }

  Widget _buildCalendar(Map<int, AttendanceStatus> data) {
    final dayHeaders = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    // March 2026 starts on Sunday (day 7 in Mon-first grid) → offset = 6
    const offset = 6; // days before 1st
    const totalDays = 31;

    return Column(
      children: [
        Row(
          children: dayHeaders.map((d) => Expanded(
            child: Center(child: Text(d, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.textLight))),
          )).toList(),
        ),
        const SizedBox(height: 3),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, crossAxisSpacing: 3, mainAxisSpacing: 3,
          ),
          itemCount: offset + totalDays,
          itemBuilder: (context, index) {
            if (index < offset) {
              return const SizedBox();
            }
            final day = index - offset + 1;
            final status = data[day];
            Color? bg;
            Color textColor = const Color(0xFF8899bb);
            bool isToday = day == 24;
            bool hasBorder = false;

            if (status == AttendanceStatus.present) { bg = AppColors.chipGreenBg; textColor = AppColors.chipGreenText; }
            else if (status == AttendanceStatus.absent) { bg = AppColors.chipRedBg; textColor = AppColors.chipRedText; }
            else if (status == AttendanceStatus.holiday) { bg = AppColors.chipBlueBg; textColor = AppColors.chipBlueText; }
            if (isToday) hasBorder = true;

            return Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: hasBorder ? Border.all(color: AppColors.primary, width: 2) : null,
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: GoogleFonts.nunito(
                    fontSize: 9,
                    fontWeight: isToday ? FontWeight.w900 : FontWeight.w700,
                    color: isToday ? AppColors.primary : textColor,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarLegend() {
    return Wrap(
      spacing: 10,
      children: [
        _LegendItem(color: AppColors.chipGreenBg, label: 'Present'),
        _LegendItem(color: AppColors.chipRedBg, label: 'Absent'),
        _LegendItem(color: AppColors.chipBlueBg, label: 'Holiday'),
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
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w900, color: valueColor)),
            Text(label, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  final double percentage;

  const _DonutChart({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76, height: 76,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(76, 76),
            painter: _DonutPainter(percentage),
          ),
          Center(
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percentage;
  _DonutPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    const strokeWidth = 9.0;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    paint.color = AppColors.borderLight;
    canvas.drawCircle(center, radius, paint);

    paint.color = AppColors.primary;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5707963, // -90 degrees
      2 * 3.14159 * percentage,
      false, paint,
    );
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
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 3),
        Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textLight)),
      ],
    );
  }
}
