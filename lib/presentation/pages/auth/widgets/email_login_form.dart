 import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';
import 'auth_text_field.dart';

/// Form untuk login dengan email & password
///
/// PRINSIP:
/// - Single Responsibility: hanya handle email/password login
/// - Encapsulation: form validation logic di dalam widget ini
/// - Reusability: bisa dipakai dimana saja
class EmailLoginForm extends StatefulWidget {
  final AuthViewModel authViewModel;
  final bool isDark;
  final VoidCallback? onRegisterTap;

  const EmailLoginForm({
    super.key,
    required this.authViewModel,
    required this.isDark,
    this.onRegisterTap,
  });

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Clear previous errors
    widget.authViewModel.clearError();

    // Validate form
    if (!_formKey.currentState!.validate()) return;

    await widget.authViewModel.signInWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          AuthTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'nama@example.com',
            prefixIcon: Icons.email_outlined,
            isDark: widget.isDark,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          AuthTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Masukkan password',
            prefixIcon: Icons.lock_outline,
            isDark: widget.isDark,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleLogin(),
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
          const SizedBox(height: 24),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleLogin,
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
                'Login',
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Register Link
          if (widget.onRegisterTap != null) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun? ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color:
                        widget.isDark
                            ? AppColors.darkOnSurface.withValues(alpha: 0.7)
                            : AppColors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onRegisterTap,
                  child: Text(
                    'Daftar',
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
