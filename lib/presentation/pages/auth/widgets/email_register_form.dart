import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../../core/validator/email_validator.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';

/// Form untuk register dengan email, password, dan display name
///
/// PRINSIP:
/// - Single Responsibility: hanya handle registrasi
/// - Validation: validasi form di dalam widget
/// - User Experience: konfirmasi password untuk keamanan
class EmailRegisterForm extends StatefulWidget {
  final AuthViewModel authViewModel;
  final bool isDark;
  final VoidCallback onSuccess;
  final VoidCallback? onLoginTap;

  const EmailRegisterForm({
    super.key,
    required this.authViewModel,
    required this.isDark,
    required this.onSuccess,
    this.onLoginTap,
  });

  @override
  State<EmailRegisterForm> createState() => _EmailRegisterFormState();
}

class _EmailRegisterFormState extends State<EmailRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Clear previous errors
    widget.authViewModel.clearError();

    // Validate form
    if (!_formKey.currentState!.validate()) return;

    // Call register
    final success = await widget.authViewModel.signUpWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );

    if (success) {
      widget.onSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            style: AppTextStyles.bodyLarge.copyWith(
              color:
                  widget.isDark
                      ? AppColors.darkOnSurface
                      : AppColors.lightOnSurface,
            ),
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap',
              prefixIcon: Icon(
                Icons.person_outline,
                color:
                    widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.greyLight.withValues(alpha: 0.3)
                          : AppColors.greyLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              if (value.length < 3) {
                return 'Nama minimal 3 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: AppTextStyles.bodyLarge.copyWith(
              color:
                  widget.isDark
                      ? AppColors.darkOnSurface
                      : AppColors.lightOnSurface,
            ),
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'nama@example.com',
              prefixIcon: Icon(
                Icons.email_outlined,
                color:
                    widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.greyLight.withValues(alpha: 0.3)
                          : AppColors.greyLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              // if (!EmailValidator.isValid(value)) {
              //   return 'Format email tidak valid';
              // }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            style: AppTextStyles.bodyLarge.copyWith(
              color:
                  widget.isDark
                      ? AppColors.darkOnSurface
                      : AppColors.lightOnSurface,
            ),
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Minimal 6 karakter',
              prefixIcon: Icon(
                Icons.lock_outline,
                color:
                    widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color:
                      widget.isDark
                          ? AppColors.darkOnSurface.withValues(alpha: 0.6)
                          : AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.greyLight.withValues(alpha: 0.3)
                          : AppColors.greyLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 6) {
                return 'Password minimal 6 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleRegister(),
            style: AppTextStyles.bodyLarge.copyWith(
              color:
                  widget.isDark
                      ? AppColors.darkOnSurface
                      : AppColors.lightOnSurface,
            ),
            decoration: InputDecoration(
              labelText: 'Konfirmasi Password',
              hintText: 'Ulangi password',
              prefixIcon: Icon(
                Icons.lock_outline,
                color:
                    widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color:
                      widget.isDark
                          ? AppColors.darkOnSurface.withValues(alpha: 0.6)
                          : AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.greyLight.withValues(alpha: 0.3)
                          : AppColors.greyLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color:
                      widget.isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Konfirmasi password tidak boleh kosong';
              }
              if (value != _passwordController.text) {
                return 'Password tidak cocok';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Register Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.isDark
                        ? AppColors.darkPrimary
                        : AppColors.lightPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Daftar',
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Login Link
          if (widget.onLoginTap != null) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun? ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color:
                        widget.isDark
                            ? AppColors.darkOnSurface.withValues(alpha: 0.7)
                            : AppColors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onLoginTap,
                  child: Text(
                    'Login',
                    style: AppTextStyles.bodySmall.copyWith(
                      color:
                          widget.isDark
                              ? AppColors.darkPrimary
                              : AppColors.lightPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
