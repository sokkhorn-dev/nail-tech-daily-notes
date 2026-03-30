import 'package:flutter/material.dart';
import 'package:nail_tech_daily_notes/core/theme/app_text_styles.dart';
import 'package:nail_tech_daily_notes/core/widgets/custom_app_bar.dart';
import 'package:nail_tech_daily_notes/core/widgets/custom_button.dart';
import '../../../../../core/constants/app_colors.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'Nails';
  final List<String> _categories = ['Nails', 'Pedicure'];

  void _saveService() {
    final name = _nameController.text.trim();
    final price = int.tryParse(_priceController.text.trim());

    if (name.isEmpty || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid data', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'name': name,
      'price': price,
      'category': _selectedCategory,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Add New Service',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Service Name
            TextField(
              controller: _nameController,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Service Name',
                labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Price
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Price (\$)',
                labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              style: AppTextStyles.bodyMedium,
              dropdownColor: AppColors.surface,
              items: _categories
                  .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c, style: AppTextStyles.bodyMedium),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedCategory = value!);
              },
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Save Button
            CustomButton(
              text: 'Save Service',
              onPressed: _saveService,
            ),
          ],
        ),
      ),
    );
  }
}