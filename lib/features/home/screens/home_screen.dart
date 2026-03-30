import 'package:flutter/material.dart';
import 'package:nail_tech_daily_notes/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_ClientEntry> _clients = [
    _ClientEntry(initials: 'SJ', name: 'Sarah J.', service: 'Full Set Acrylic', amount: 55, tip: 10),
    _ClientEntry(initials: 'ML', name: 'Mia L.', service: 'Gel Pedicure', amount: 45, tip: 8),
    _ClientEntry(initials: 'KR', name: 'Kate R.', service: 'Fill + Nail Art', amount: 65, tip: 15),
  ];

  int get _totalService => _clients.fold(0, (sum, c) => sum + c.amount);
  int get _totalTips => _clients.fold(0, (sum, c) => sum + c.tip);

  void _addClient() {
    Navigator.pushNamed(context, AppRoutes.addClient);
  }

  String _todayDate() {
    final now = DateTime.now();
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "Today's Log",
                            style: AppTextStyles.h3
                        ),
                        Text(
                          _todayDate(),
                          style:  AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _addClient,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              // ✅ Summary Cards
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        label: 'Services',
                        value: '\$$_totalService',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _SummaryCard(
                        label: 'Tips',
                        value: '\$$_totalTips',
                        isAccent: true,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Clients Label
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 6),
                child: Text('CLIENTS TODAY', style: AppTextStyles.labelMuted),
              ),

              // ✅ Client List
              ..._clients.map((c) => _ClientRow(client: c)),

              // ✅ Add Client Button
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addClient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('+ Add Client', style: AppTextStyles.buttonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// Models & Sub-Widgets
// ──────────────────────────────────────────

class _ClientEntry {
  final String initials;
  final String name;
  final String service;
  final int amount;
  final int tip;

  const _ClientEntry({
    required this.initials,
    required this.name,
    required this.service,
    required this.amount,
    required this.tip,
  });
}

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
          Text(label, style: AppTextStyles.labelMuted),
          const SizedBox(height: 4),
          Text(
            value,
            style: isAccent
                ? AppTextStyles.pricePrimary
                : AppTextStyles.h3,
          ),
        ],
      ),
    );
  }
}

class _ClientRow extends StatelessWidget {
  final _ClientEntry client;

  const _ClientRow({required this.client});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(client.initials, style: AppTextStyles.labelMuted),
            ),
          ),
          const SizedBox(width: 10),

          // Name & Service
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.name, style: AppTextStyles.bodyMedium),
                Text(client.service, style: AppTextStyles.labelMuted),
              ],
            ),
          ),

          // Amount & Tip
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${client.amount}', style: AppTextStyles.bodyMedium),
              Text('+\$${client.tip} tip', style: AppTextStyles.labelMuted),
            ],
          ),
        ],
      ),
    );
  }
}