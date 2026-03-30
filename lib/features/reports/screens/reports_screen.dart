import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final String _currentMonth = 'March 2026';

  final List<_WeekData> _weeklyData = [
    _WeekData(label: 'W1', amount: 620, percentage: 0.75),
    _WeekData(label: 'W2', amount: 740, percentage: 0.90),
    _WeekData(label: 'W3', amount: 510, percentage: 0.60),
    _WeekData(label: 'W4', amount: 470, percentage: 0.56),
  ];

  final List<_TopService> _topServices = [
    _TopService(name: 'Full Set Acrylic', count: 32),
    _TopService(name: 'Gel Pedicure', count: 18),
    _TopService(name: 'Fill In', count: 14),
  ];

  int get _totalMonth => _weeklyData.fold(0, (sum, w) => sum + w.amount);
  int get _totalTips => 318;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reports',
                        style: AppTextStyles.h3,
                      ),
                      Text(
                        _currentMonth,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'This month',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),


            // Summary Cards
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'This month',
                      value: '\$$_totalMonth',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Total tips',
                      value: '\$$_totalTips',
                      isAccent: true,
                    ),
                  ),
                ],
              ),
            ),

            // Weekly Income Chart
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
              child: Text(
                'INCOME BY WEEK',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ..._weeklyData.map((w) => _WeekBarRow(data: w)),

            // Top Services
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 8),
              child: Text(
                'TOP SERVICES',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ..._topServices.map((s) => _TopServiceRow(service: s)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Data Models ──────────────────────────────────────────────────────────────

class _WeekData {
  final String label;
  final int amount;
  final double percentage;
  const _WeekData({
    required this.label,
    required this.amount,
    required this.percentage,
  });
}

class _TopService {
  final String name;
  final int count;
  const _TopService({required this.name, required this.count});
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isAccent;
  const _SummaryCard({
    required this.label,
    required this.value,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: isAccent ? AppColors.primary : AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekBarRow extends StatelessWidget {
  final _WeekData data;
  const _WeekBarRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              data.label,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.percentage,
                backgroundColor: AppColors.border,
                color: AppColors.primary,
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              '\$${data.amount}',
              textAlign: TextAlign.right,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopServiceRow extends StatelessWidget {
  final _TopService service;
  const _TopServiceRow({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service.name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${service.count} times',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}