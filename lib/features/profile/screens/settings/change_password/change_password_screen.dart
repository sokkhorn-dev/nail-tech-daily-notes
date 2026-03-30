import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentPass  = TextEditingController();
  final _newPass      = TextEditingController();
  final _confirmPass  = TextEditingController();

  bool _isLoading = false;
  bool _obscure1  = true;
  bool _obscure2  = true;
  bool _obscure3  = true;

  @override
  void dispose() {
    _currentPass.dispose();
    _newPass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  void _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
          content: Text(
            'Password updated successfully',
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ ប្តូរទៅ CustomAppBar — លុប _header ចោល
      appBar: CustomAppBar(
        title: 'Change Password',
        showBackButton: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ✅ ប្តូរ _passwordField ទៅ CustomTextField
              CustomTextField(
                controller: _currentPass,
                label: 'Current Password',
                hint: 'Enter current password',
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscure1,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure1 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.textMuted,
                  ),
                  onPressed: () => setState(() => _obscure1 = !_obscure1),
                ),
                validator: (v) =>
                v == null || v.length < 6 ? 'Min 6 characters' : null,
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: _newPass,
                label: 'New Password',
                hint: 'Enter new password',
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscure2,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure2 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.textMuted,
                  ),
                  onPressed: () => setState(() => _obscure2 = !_obscure2),
                ),
                validator: (v) =>
                v == null || v.length < 6 ? 'Min 6 characters' : null,
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: _confirmPass,
                label: 'Confirm Password',
                hint: 'Re-enter new password',
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscure3,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure3 ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.textMuted,
                  ),
                  onPressed: () => setState(() => _obscure3 = !_obscure3),
                ),
                validator: (v) =>
                v != _newPass.text ? 'Passwords do not match' : null,
              ),

              const Spacer(),

              // ✅ ប្តូរ Button ឱ្យ consistent
              _isLoading
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Update Password',
                    // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}