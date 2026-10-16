import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../widgets/profile_summary_card.dart';

/// Профіль користувача (ФВ-4): особисті дані, зміна пароля,
/// налаштування сповіщень і вихід з акаунта.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifyResponses = true;
  bool _notifySimilar = true;
  bool _notifyNews = false;

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSummaryCard(
                  onChangePhoto: () =>
                      _showMessage('Вибір фото буде реалізовано пізніше'),
                ),
                const SizedBox(height: AppSpacing.small),
                TextButton.icon(
                  onPressed: _logout,
                  style: TextButton.styleFrom(foregroundColor: AppColors.error),
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text(
                    'Вийти з акаунта',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                _buildNotificationsCard(),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.large),
          Expanded(
            child: Column(
              children: [
                _buildPersonalDataCard(),
                const SizedBox(height: AppSpacing.large),
                _buildPasswordCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDataCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Особисті дані'),
          const SizedBox(height: AppSpacing.large),
          const Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Ім’я',
                  initialValue: MockData.userFirstName,
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: AppTextField(
                  label: 'Прізвище',
                  initialValue: MockData.userLastName,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          const Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Електронна пошта',
                  initialValue: MockData.userEmail,
                  prefixIcon: Icons.mail_outline,
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: AppTextField(
                  label: 'Телефон',
                  initialValue: MockData.userPhone,
                  prefixIcon: Icons.phone_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Зберегти',
              onPressed: () => _showMessage('Зміни профілю збережено'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Зміна пароля',
            subtitle: 'Після зміни ви вийдете з інших пристроїв',
          ),
          const SizedBox(height: AppSpacing.large),
          const AppTextField(
            label: 'Поточний пароль',
            hint: 'Введіть поточний пароль',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: AppSpacing.medium),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Новий пароль',
                  hint: 'Мінімум 8 символів',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: AppTextField(
                  label: 'Повторіть пароль',
                  hint: 'Повторіть новий пароль',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Оновити пароль',
              onPressed: () => _showMessage('Пароль успішно змінено'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Сповіщення'),
          const SizedBox(height: AppSpacing.small),
          _SwitchRow(
            label: 'Відгуки на оголошення',
            value: _notifyResponses,
            onChanged: (v) => setState(() => _notifyResponses = v),
          ),
          _SwitchRow(
            label: 'Схожі знахідки поруч',
            value: _notifySimilar,
            onChanged: (v) => setState(() => _notifySimilar = v),
          ),
          _SwitchRow(
            label: 'Новини сервісу',
            value: _notifyNews,
            onChanged: (v) => setState(() => _notifyNews = v),
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13.5, color: AppColors.textPrimary),
          ),
        ),
        Switch(
          value: value,
          activeTrackColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
