import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/user_avatar.dart';

/// Верхня панель: заголовок розділу, пошук, сповіщення та користувач.
class TopBar extends StatelessWidget {
  final String title;
  final bool showSearch;
  final VoidCallback onProfileTap;
  final VoidCallback onNotificationsTap;

  const TopBar({
    super.key,
    required this.title,
    required this.showSearch,
    required this.onProfileTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          if (showSearch)
            const SizedBox(width: 380, child: AppSearchField()),
          const SizedBox(width: AppSpacing.medium),
          IconButton(
            tooltip: 'Сповіщення',
            onPressed: onNotificationsTap,
            icon: const Badge(
              smallSize: 8,
              backgroundColor: AppColors.accent,
              child: Icon(
                Icons.notifications_none,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(24),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: Row(
                children: [
                  UserAvatar(initials: MockData.userInitials, size: 32),
                  SizedBox(width: AppSpacing.small),
                  Text(
                    MockData.userName,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
