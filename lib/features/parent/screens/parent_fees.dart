import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../models/app_models.dart';
import '../../../services/dummy_data_service.dart';

class ParentFeesScreen extends StatelessWidget {
  const ParentFeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fees = DummyDataService.feeItems;
    final transactions = DummyDataService.feeTransactions;
    final totalFee = fees.fold<double>(0, (sum, f) => sum + f.amount);
    final paidFee = fees.where((f) => f.status == FeeStatus.paid).fold<double>(0, (sum, f) => sum + f.amount);

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
          AppTopBar(title: 'Fee & Payments'),
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
                    // Status card - green (all paid)
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF1a9e75), Color(0xFF0d7a58)]),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('2025–26 Fee Status · Aryan Mehta', style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('₹${totalFee.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}', style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                                  Text('Total Annual Fee', style: GoogleFonts.nunito(fontSize: 9, color: Colors.white.withValues(alpha: 0.85))),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(99)),
                                child: Text('All Paid ✓', style: GoogleFonts.nunito(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: paidFee / totalFee,
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              valueColor: const AlwaysStoppedAnimation(Colors.white),
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Paid: ₹${paidFee.toInt()}', style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                              Text('Balance: ₹${(totalFee - paidFee).toInt()}', style: GoogleFonts.nunito(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Fee breakdown
                    const SectionTitle('Fee Breakdown'),
                    AppCard(
                      marginBottom: 11,
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      child: Column(
                        children: fees.asMap().entries.map((e) {
                          final i = e.key;
                          final fee = e.value;
                          final isLast = i == fees.length - 1;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderLight))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(fee.name, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                      if (fee.paidDate != null) Text('Paid: ${fee.paidDate}', style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('₹${fee.amount.toInt()}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.success)),
                                    const SizedBox(height: 2),
                                    AppChip.green('Paid', fontSize: 8),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Transactions
                    const SectionTitle('Transaction History'),
                    ...transactions.map((t) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border)),
                      child: Row(
                        children: [
                          Container(
                            width: 34, height: 34,
                            decoration: BoxDecoration(color: AppColors.chipGreenBg, borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Text('🧾', style: TextStyle(fontSize: 16))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.title, style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                                Text(t.subtitle, style: GoogleFonts.nunito(fontSize: 9, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('₹${t.amount.toInt()}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.success)),
                              Text('⬇️', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
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
