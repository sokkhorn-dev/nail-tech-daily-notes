import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // កែតម្រូវតាម path របស់អ្នក
import '../theme/app_text_styles.dart'; // ប្រើជាមួយ class text style ដែលយើងទើបបង្កើត

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.text),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.h3, // ប្រើ Style ពី class យើង
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),
        ],
      ),
      actions: actions != null
          ? [
        ...actions!,
        const SizedBox(width: 8), // ផ្ដល់ចន្លោះខាងចុងបន្តិច
      ]
          : null,
      shape: const Border(
        bottom: BorderSide(color: AppColors.border, width: 0.5),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 70 : 60);
}