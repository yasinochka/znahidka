import 'package:flutter/material.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../widgets/auth_layout.dart';

/// Екран входу до акаунта (ФВ-1).
/// Без бізнес-логіки: кнопка «Увійти» одразу відкриває головну сторінку.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;

  void _login() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      headline: 'Загубили?\nЗнайшли?',
      description: 'Публікуйте оголошення з фото й описом — '
          'ми допоможемо речам повернутися додому.',
      footerHint: 'Enter — увійти · Tab — наступне поле',
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthFormHeader(
            title: 'Вхід до акаунта',
            subtitle: 'Раді знову бачити вас',
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppTextField(
            label: 'Електронна пошта',
            hint: 'name@gmail.com',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.medium),
          const AppTextField(
            label: 'Пароль',
            hint: 'Введіть пароль',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: AppSpacing.normal),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _rememberMe,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              const Expanded(
                child: Text(
                  'Запам’ятати мене',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.forgotPassword),
                child: const Text(
                  'Забули пароль?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          PrimaryButton(label: 'Увійти', onPressed: _login, expanded: true),
          const SizedBox(height: AppSpacing.medium),
          const _OrDivider(),
          const SizedBox(height: AppSpacing.medium),
          SecondaryButton(
            label: 'Увійти через Google',
            icon: Icons.account_circle_outlined,
            onPressed: _login,
            expanded: true,
          ),
          const SizedBox(height: AppSpacing.large),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Ще немає акаунта?',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                  child: const Text(
                    'Зареєструватися',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.normal),
          child: Text(
            'або',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
