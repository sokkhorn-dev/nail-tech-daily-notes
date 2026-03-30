import 'package:flutter/material.dart';
import 'package:nail_tech_daily_notes/core/widgets/custom_app_bar.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Add Client'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionLabel('Client'),
            _buildCardWrapper([
              _buildFormRow('Name', 'Sarah Johnson', isFilled: true),
              _buildFormRow('Date & Time', 'Today, 2:00 PM', isFilled: true),
            ]),

            _buildSectionLabel('Service'),
            _buildCardWrapper([
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ServiceChip(label: 'Full Set', isSelected: true),
                    _ServiceChip(label: 'Fill In'),
                    _ServiceChip(label: 'Gel Mani'),
                    _ServiceChip(label: 'Pedicure'),
                    _ServiceChip(label: '+ More'),
                  ],
                ),
              ),
            ]),

            _buildSectionLabel('Payment'),
            _buildCardWrapper([
              _buildAmountRow('Service \$', '55'),
              _buildTipRow(),
              _buildFormRow('Note', 'Add a note...', hasChevron: false),
            ]),

            const SizedBox(height: 12),
            _buildTotalBar(),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: 'Save Client',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textMuted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCardWrapper(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildFormRow(String label, String value, {bool isFilled = false, bool hasChevron = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isFilled ? AppColors.text : AppColors.textMuted,
            ),
          ),
          if (hasChevron) ...[
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          const Spacer(),
          Text('\$', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted)),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(width: 2, height: 16, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildTipRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: const Row(
        children: [
          Text('Tip', style: TextStyle(fontSize: 13, color: AppColors.text)),
          Spacer(),
          _ServiceChip(label: '\$10', isSelected: true),
        ],
      ),
    );
  }

  Widget _buildTotalBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total collected',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$65',
            style: AppTextStyles.h2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _ServiceChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryLight : AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: isSelected ? AppColors.primary : AppColors.text,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}