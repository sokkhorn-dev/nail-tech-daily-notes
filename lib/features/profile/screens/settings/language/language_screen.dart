import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'English';

  final List<Map<String, String>> languages = [
    {"name": "English", "flag": "🇺🇸"},
    {"name": "Khmer",   "flag": "🇰🇭"},
    {"name": "Vietnamese", "flag": "🇻🇳"},
    {"name": "Spanish", "flag": "🇪🇸"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ ប្តូរទៅ CustomAppBar — លុប _buildHeader ចោល
      appBar: CustomAppBar(
        title: 'Language',
        showBackButton: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          return _languageCard(
            name: lang["name"]!,
            flag: lang["flag"]!,
          );
        },
      ),
    );
  }

  // ── Language Card ──
  Widget _languageCard({required String name, required String flag}) {
    final isSelected = _selected == name;

    return GestureDetector(
      onTap: () => setState(() => _selected = name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            // ── Flag ──
            Text(flag, style: AppTextStyles.bodySmall.copyWith(fontSize: 20)),

            const SizedBox(width: 12),

            // ── Language Name ──
            Expanded(
              child: Text(
                name,
                // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primary : AppColors.text,
                ),
              ),
            ),

            // ── Check Icon ──
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}