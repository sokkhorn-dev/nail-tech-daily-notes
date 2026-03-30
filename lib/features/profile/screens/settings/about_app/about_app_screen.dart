import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ ប្តូរទៅ CustomAppBar — លុប _header ចោល
      appBar: CustomAppBar(
        title: 'About App',
        showBackButton: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── App Icon ──
            const Icon(Icons.spa, size: 80, color: AppColors.primary),

            const SizedBox(height: 16),

            // ── App Name ──
            Text(
              'Nail Salon App',
              style: AppTextStyles.h2,
            ),

            const SizedBox(height: 8),

            // ── Version ──
            Text(
              'Version 1.0.0',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),

            const SizedBox(height: 24),

            // ── Description ──
            Text(
              'This app helps nail technicians manage clients, appointments, and earnings efficiently.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),

            const Spacer(),

            // ── Footer ──
            Text(
              '© 2026 Your Company',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}