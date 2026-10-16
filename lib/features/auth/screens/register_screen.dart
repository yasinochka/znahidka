import 'package:flutter/material.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../widgets/auth_layout.dart';

/// Екран реєстрації нового користувача (ФВ-1).
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _acceptedTerms = false;

  void _register() {
    // Без бізнес-логіки: одразу переходимо на головну сторінку
    // та очищаємо стек маршрутів авторизації.
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      headline: 'Створіть\nакаунт',
      description: 'Щоб публікувати оголошення, відповідати власникам '
          'і отримувати сповіщення.',
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthFormHeader(
            title: 'Реєстрація',
            subtitle: 'Займе менше хвилини',
          ),
          const SizedBox(height: AppSpacing.large),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: AppTextField(label: 'Ім’я', hint: 'Ліза')),
              SizedBox(width: AppSpacing.normal),
              Expanded(child: AppTextField(label: 'Прізвище', hint: 'Ясінська')),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          const AppTextField(
            label: 'Електронна пошта',
            hint: 'name@gmail.com',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.medium),
          const AppTextField(
            label: 'Телефон (необов’язково)',
            hint: '+380 __ ___ __ __',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.medium),
          const AppTextField(
            label: 'Пароль',
            hint: 'Мінімум 8 символів',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            helperText: 'Мінімум 8 символів, цифра та літера',
          ),
          const SizedBox(height: AppSpacing.medium),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _acceptedTerms,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              const Expanded(
                child: Text(
                  'Погоджуюся з правилами сервісу та політикою конфіденційності',
                  style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          PrimaryButton(
            label: 'Створити акаунт',
            onPressed: _acceptedTerms ? _register : null,
            expanded: true,
          ),
          const SizedBox(height: AppSpacing.medium),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Вже маєте акаунт?',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Увійти',
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
