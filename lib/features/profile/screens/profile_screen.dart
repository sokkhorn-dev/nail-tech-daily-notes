import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // ── Profile Avatar + Name ──
            _buildProfileHeader(),

            const SizedBox(height: 32),

            // ── Info Tiles ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date Joined',
                    subLabel: 'March 2016',
                    value: 'March 10, 2024',
                  ),
                  const SizedBox(height: 12),
                  _InfoTile(
                    icon: Icons.people_outline,
                    label: 'Total Clients',
                    subLabel: 'Sept 2026',
                    value: '127 Clients',
                  ),
                  const SizedBox(height: 12),
                  _InfoTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Total Earnings',
                    subLabel: 'Today',
                    value: '\$9,230',
                  ),
                  const SizedBox(height: 12),

                  // ── Rating Tile ──
                  _buildRatingTile(),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Action Buttons ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Edit Profile',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      label: 'Settings',
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── Profile Avatar + Name ──
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://www.w3schools.com/howto/img_avatar2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        const Text('Chu E', style: AppTextStyles.h2),
        const SizedBox(height: 4),
        Text(
          'Nail Technician',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  // ── Rating Tile ──
  Widget _buildRatingTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          const _IconBox(icon: Icons.storefront_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
                Text('Rating',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    )),
                Text('Oct 2020',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    )),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) => Icon(
              index < 4 ? Icons.star : Icons.star_half,
              size: 14,
              color: Colors.orange,
            )),
          ),
          const SizedBox(width: 4),
          Text('4.7',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────
// 🔹 Icon Box
// ─────────────────────────────
class _IconBox extends StatelessWidget {
  final IconData icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}

// ─────────────────────────────
// 🔹 Info Tile
// ─────────────────────────────
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          _IconBox(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
                Text(label,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    )),
                Text(subLabel,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    )),
              ],
            ),
          ),
          Text(value,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────
// 🔹 Action Button
// ─────────────────────────────
class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.primaryLight,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isPrimary ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}