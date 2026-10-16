import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/user_avatar.dart';

/// Картка з аватаром, іменем та короткою статистикою користувача.
class ProfileSummaryCard extends StatelessWidget {
  final VoidCallback onChangePhoto;

  const ProfileSummaryCard({super.key, required this.onChangePhoto});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const UserAvatar(initials: MockData.userInitials, size: 96),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 3),
                  ),
                  child: const Icon(
                    Icons.photo_camera_outlined,
                    size: 15,
                    color: AppColors.textOnDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          const Text(
            MockData.userName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            MockData.userEmail,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.large),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(value: '3', label: 'Активні'),
              _StatItem(value: '4', label: 'Повернуто'),
              _StatItem(value: '2025', label: 'З нами з'),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          SecondaryButton(
            label: 'Змінити фото профілю',
            icon: Icons.upload_outlined,
            onPressed: onChangePhoto,
            expanded: true,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
