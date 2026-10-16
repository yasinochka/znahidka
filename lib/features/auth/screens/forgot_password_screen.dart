import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../widgets/auth_layout.dart';

/// Екран відновлення пароля через електронну пошту (ФВ-1).
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLinkSent = false;

  void _sendLink() {
    // Без бізнес-логіки: лише показуємо повідомлення про успішне надсилання.
    setState(() {
      _isLinkSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      headline: 'Відновимо\nдоступ',
      description: 'Надішлемо посилання для скидання пароля '
          'на вашу електронну пошту.',
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(Icons.chevron_left, size: 20),
            label: const Text(
              'Назад до входу',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: const Icon(Icons.lock_outline, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.medium),
          const AuthFormHeader(
            title: 'Забули пароль?',
            subtitle: 'Введіть пошту, вказану під час реєстрації.\n'
                'Ми надішлемо лист із посиланням (діє 30 хв).',
          ),
          const SizedBox(height: AppSpacing.large),
          const AppTextField(
            label: 'Електронна пошта',
            hint: 'name@gmail.com',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.large),
          PrimaryButton(
            label: 'Надіслати посилання',
            onPressed: _sendLink,
            expanded: true,
          ),
          if (_isLinkSent) ...[
            const SizedBox(height: AppSpacing.large),
            const _SuccessMessage(),
          ],
        ],
      ),
    );
  }
}

class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: AppColors.successBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: const Color(0xFFBFE3CB)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 22),
          SizedBox(width: AppSpacing.normal),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Лист надіслано на вашу пошту',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Не бачите листа? Перевірте «Спам» '
                  'або надішліть ще раз через 01:45.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
