import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController  = TextEditingController();
  final _emailController     = TextEditingController();
  final _passwordController  = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_firstNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white), // ✅
          ),
          backgroundColor: AppColors.error, // ✅
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return; // ✅ mounted check

    // TODO: Add Firebase Auth register
    // ✅ បន្ទាប់ register ជោគជ័យ → ទៅ login
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ✅
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ✅ Back button ប្រើ Icon + AppTextStyles
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Back',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ✅ Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.33,
                  backgroundColor: AppColors.border,
                  color: AppColors.primary,
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Title ប្រើ AppTextStyles
              Text('Create account', style: AppTextStyles.h1),
              const SizedBox(height: 4),
              Text(
                'Join thousands of nail techs',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 22),

              // First & Last Name Row
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _firstNameController,
                      hint: 'Sokkhorn',
                      label: 'First name',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: _lastNameController,
                      hint: 'IM',
                      label: 'Last name',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Email
              CustomTextField(
                controller: _emailController,
                hint: 'your@email.com',
                label: 'Email address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              // Password
              CustomTextField(
                controller: _passwordController,
                hint: 'Min. 8 characters',
                label: 'Password',
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 1,
                      child: Text(
                        _obscurePassword ? 'Show' : 'Hide',
                        style: AppTextStyles.bodySmall.copyWith( // ✅
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Terms ប្រើ AppTextStyles
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.labelMuted.copyWith( // ✅
                    color: AppColors.textMuted,
                    height: 1.6,
                  ),
                  children: [
                    const TextSpan(text: 'By signing up you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppTextStyles.labelMuted.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.labelMuted.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Register Button
              CustomButton(
                text: 'Create account',
                onPressed: _register,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),

              // ✅ Sign In Link ប្រើ pushReplacementNamed
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: AppTextStyles.bodySmall.copyWith( // ✅
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: AppTextStyles.bodySmall.copyWith( // ✅
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}