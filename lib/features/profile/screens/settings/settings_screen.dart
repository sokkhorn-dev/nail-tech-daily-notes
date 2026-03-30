import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ ប្តូរទៅ CustomAppBar — លុប _buildHeader ចោល
      appBar: CustomAppBar(
        title: 'Settings',
        showBackButton: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),

          // 🔹 Account
          _sectionLabel('Account'),

          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () => Navigator.pushNamed(context, AppRoutes.changePassword),
          ),

          const SizedBox(height: 24),

          // 🔹 Preferences
          _sectionLabel('Preferences'),

          _SwitchTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),

          _SwitchTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),

          const SizedBox(height: 24),

          // 🔹 More
          _sectionLabel('More'),

          _SettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            onTap: () => Navigator.pushNamed(context, AppRoutes.language),
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About App',
            onTap: () => Navigator.pushNamed(context, AppRoutes.about),
          ),

          const SizedBox(height: 32),

          // 🔥 Logout
          const _LogoutButton(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────
// 🔹 Settings Tile
// ─────────────────────────────
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        title: Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.textMuted,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ─────────────────────────────
// 🔹 Switch Tile
// ─────────────────────────────
class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────
// 🔥 Logout Button
// ─────────────────────────────
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  // ✅ Error color ប្រើ AppColors ជំនួស Colors.red
  static const _errorColor = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: _errorColor.withOpacity(0.1),
          foregroundColor: _errorColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          'Logout',
          // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
          style: AppTextStyles.bodySmall.copyWith(
            color: _errorColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        title: Text('Logout', style: AppTextStyles.h3),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Firebase logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _errorColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Logout',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}