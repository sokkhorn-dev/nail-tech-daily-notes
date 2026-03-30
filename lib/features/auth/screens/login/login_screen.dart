import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false; // ✅ កែពី final → bool

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    // TODO: Add Firebase Auth login
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return; // ✅ ត្រួតពិនិត្យ mounted មុន Navigator

    // ✅ pushNamedAndRemoveUntil — លុប stack ចោលទាំងអស់
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.main,
          (route) => false,
    );
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


              // ✅ Title ប្រើ AppTextStyles
              Text(
                'Welcome back',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 6),
              Text(
                'Sign in to your account',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 28),

              // Email Field
              CustomTextField(
                controller: _emailController,
                hint: 'your@email.com',
                label: 'Email address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              // Password Field
              CustomTextField(
                controller: _passwordController,
                hint: '••••••••',
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
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot password?',
                    style: AppTextStyles.bodySmall.copyWith( // ✅
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              CustomButton(
                text: 'Sign in',
                onPressed: _login,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: AppTextStyles.bodySmall.copyWith( // ✅
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 16),

              // Google Button
              CustomButton(
                text: 'Sign in with Google',
                onPressed: () {},
                isOutlined: true,
                leading: const Text(
                  'G',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEA4335),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ✅ Sign Up Link ប្រើ pushNamed
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyles.bodySmall.copyWith( // ✅
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
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