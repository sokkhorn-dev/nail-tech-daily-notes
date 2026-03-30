import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';          // ថ្មី
import '../../../../../core/widgets/custom_app_bar.dart';         // ថ្មី
import '../../../../../core/widgets/custom_textfield.dart';
// ថ្មី

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController  = TextEditingController(text: 'Chu E');
  final _titleController = TextEditingController(text: 'Nail Technician');
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController   = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      // ✅ ប្តូរពី Navigator.pop → pushNamed ត្រឡប់ទៅ profile
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ✅ ប្តូរទៅ CustomAppBar — លុប _buildHeader ចោល
      appBar: CustomAppBar(
        title: 'Edit Profile',
        showBackButton: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              _buildAvatarPicker(),

              const SizedBox(height: 32),

              // ── Basic Info ──
              _sectionLabel('Basic Info'),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _nameController,
                label: 'Full Name',
                hint: 'e.g. Chu E',
                prefixIcon: const Icon(Icons.person_outline),
                validator: (v) =>
                (v == null || v.isEmpty) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _titleController,
                label: 'Job Title',
                hint: 'e.g. Nail Technician',
                prefixIcon: const Icon(Icons.work_outline),
                validator: (v) =>
                (v == null || v.isEmpty) ? 'Please enter your title' : null,
              ),

              const SizedBox(height: 24),

              // ── Contact ──
              _sectionLabel('Contact'),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'e.g. +1 515 000 0000',
                prefixIcon: const Icon(Icons.phone_outlined),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _emailController,
                label: 'Email Address',
                hint: 'e.g. chu@example.com',
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              // ── About ──
              _sectionLabel('About'),
              const SizedBox(height: 12),

              CustomTextField(
                controller: _bioController,
                label: 'Bio',
                hint: 'Write a short bio about yourself...',
                prefixIcon: const Icon(Icons.notes_outlined),
                maxLines: 4,
              ),

              const SizedBox(height: 32),

              // ── Buttons ──
              Row(
                children: [
                  Expanded(
                    child: _OutlineBtn(
                      label: 'Cancel',
                      // ✅ ប្តូរទៅ pushNamed
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _isSaving
                        ? _loadingButton()
                        : _PrimaryBtn(
                      label: 'Save Changes',
                      onPressed: _saveProfile,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Avatar Picker ──
  Widget _buildAvatarPicker() {
    return Center(
      child: Stack(
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
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // TODO: ភ្ជាប់ image picker
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _loadingButton() {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      ),
    );
  }
}

// ── Primary Button ──
class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _PrimaryBtn({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        child: Text(label, style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        )),
      ),
    );
  }
}

// ── Outline Button ──
class _OutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _OutlineBtn({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // ✅ ប្តូរ TextStyle ទៅ AppTextStyles
        child: Text(label, style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        )),
      ),
    );
  }
}