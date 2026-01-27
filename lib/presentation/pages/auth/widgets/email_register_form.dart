import 'package:flutter/material.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../viewmodels/auth/auth_viewmodel.dart';
import 'auth_text_field.dart';

class EmailRegisterForm extends StatefulWidget {
  final AuthViewModel authViewModel;
  final bool isDark;

  final VoidCallback? onLoginTap;

  const EmailRegisterForm({
    super.key,
    required this.authViewModel,
    required this.isDark,

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
    widget.authViewModel.clearError();

    if (!_formKey.currentState!.validate()) return;

    await widget.authViewModel.signUpWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: _nameController,
            labelText: 'Nama Lengkap',
            hintText: 'Masukkan nama lengkap',
            prefixIcon: Icons.person_outline,
            isDark: widget.isDark,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validator: UiFieldValidators.nameOnly('Nama Lengkap'),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'nama@example.com',
            prefixIcon: Icons.email_outlined,
            isDark: widget.isDark,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: UiFieldValidators.email('Email'),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Minimal 6 karakter',
            prefixIcon: Icons.lock_outline,
            isDark: widget.isDark,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
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
            validator: UiFieldValidators.passwordMin6('Password'),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            controller: _confirmPasswordController,
            labelText: 'Konfirmasi Password',
            hintText: 'Ulangi password',
            prefixIcon: Icons.lock_outline,
            isDark: widget.isDark,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleRegister(),
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
            validator: UiFieldValidators.confirmPassword(
              _passwordController.text,
              'Konfirmasi Password',
            ),
          ),
          const SizedBox(height: 24),

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
