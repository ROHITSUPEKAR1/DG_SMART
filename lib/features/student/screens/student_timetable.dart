import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../services/dummy_data_service.dart';

class StudentTimetableWidget extends StatefulWidget {
  const StudentTimetableWidget({super.key});

  @override
  State<StudentTimetableWidget> createState() => _StudentTimetableWidgetState();
}

class _StudentTimetableWidgetState extends State<StudentTimetableWidget> {
  int _selectedDay = 1; // 0=Mon, 1=Tue, 2=Wed...

  final _days = [
    {'abbr': 'MON', 'num': '23'},
    {'abbr': 'TUE', 'num': '24'},
    {'abbr': 'WED', 'num': '25'},
    {'abbr': 'THU', 'num': '26'},
    {'abbr': 'FRI', 'num': '27'},
    {'abbr': 'SAT', 'num': '28'},
  ];

  @override
  Widget build(BuildContext context) {
    final timetable = DummyDataService.timetable;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day scroll
        SizedBox(
          height: 62,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final isSelected = i == _selectedDay;
              return GestureDetector(
                onTap: () => setState(() => _selectedDay = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.0),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_days[i]['abbr']!, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: isSelected ? AppColors.textMuted : AppColors.textLight)),
                      Text(_days[i]['num']!, style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w900, color: isSelected ? AppColors.primary : AppColors.textPrimary)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Today banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tuesday, 24 March', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
                  Text('6 periods today', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textLight)),
                ],
              ),
              AppChip.green('Today'),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Periods
        ...timetable.asMap().entries.map((e) {
          final i = e.key;
          final period = e.value;
          // Insert breaks
          Widget? breakWidget;
          if (i == 2) {
            breakWidget = _buildBreak('☕ Short Break · 10:00–10:15 AM');
          } else if (i == 4) {
            breakWidget = _buildBreak('🍱 Lunch · 12:15–1:00 PM');
          }

          return Column(
            children: [
              if (breakWidget != null) ...[breakWidget, const SizedBox(height: 8)],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time column
                  SizedBox(
                    width: 40,
                    child: Column(
                      children: [
                        Text(period.startTime, textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: period.isNow ? AppColors.primary : AppColors.textLight, height: 1.2)),
                        const SizedBox(height: 4),
                        Container(width: 2, height: 36, color: period.isNow ? AppColors.primary : AppColors.borderLight),
                        Container(
                          width: 7, height: 7,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: period.isNow ? AppColors.primary : AppColors.borderLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Period card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: period.isNow ? Colors.white : period.bgColor,
                        borderRadius: BorderRadius.circular(14),
                        border: period.isNow ? Border.all(color: AppColors.primary, width: 1.5) : null,
                        boxShadow: period.isNow ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.12), blurRadius: 10, offset: const Offset(0, 2))] : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(color: period.isNow ? AppColors.chipGreenBg : Colors.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(period.icon, style: const TextStyle(fontSize: 14))),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(period.subject, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: period.isNow ? AppColors.textPrimary : period.textColor)),
                                Text(period.teacher, style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w700, color: period.isNow ? AppColors.textLight : period.textColor.withValues(alpha: 0.8))),
                                const SizedBox(height: 3),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(color: period.isNow ? AppColors.chipGreenBg : Colors.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(99)),
                                  child: Text(period.room, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: period.isNow ? AppColors.chipGreenText : period.textColor)),
                                ),
                              ],
                            ),
                          ),
                          if (period.isNow)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                              child: Text('Now', style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildBreak(String label) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(label, style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
        ),
        Expanded(child: Container(height: 1, color: AppColors.border)),
      ],
    );
  }
}
