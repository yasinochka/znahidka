import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/lost_item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/status_badge.dart';

/// Спільний макет екранів авторизації:
/// ліворуч — брендована панель, праворуч — форма.
class AuthLayout extends StatelessWidget {
  final String headline;
  final String description;
  final Widget form;
  final String? footerHint;

  const AuthLayout({
    super.key,
    required this.headline,
    required this.description,
    required this.form,
    this.footerHint,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: _BrandPanel(headline: headline, description: description),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: form,
                      ),
                    ),
                  ),
                ),
                if (footerHint != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.large),
                    child: Text(
                      footerHint!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
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

class _BrandPanel extends StatelessWidget {
  final String headline;
  final String description;

  const _BrandPanel({required this.headline, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLogo(),
          const Spacer(),
          Text(
            headline,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnDark,
              height: 1.15,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textOnDarkMuted,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 3; i++) ...[
                Padding(
                  // Середня картка трохи зміщена вниз.
                  padding: EdgeInsets.only(top: i == 1 ? 24 : 0),
                  child: _MiniItemCard(item: MockData.items[i]),
                ),
                if (i < 2) const SizedBox(width: AppSpacing.medium),
              ],
            ],
          ),
          const Spacer(),
          const Text(
            'Понад 12 000 речей вже повернулися до власників',
            style: TextStyle(fontSize: 12.5, color: AppColors.textOnDarkMuted),
          ),
        ],
      ),
    );
  }
}

class _MiniItemCard extends StatelessWidget {
  final LostItem item;

  const _MiniItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppSpacing.small),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 84,
            decoration: BoxDecoration(
              color: item.imageColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: const Center(
              child: Icon(
                Icons.image_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          StatusBadge(type: item.type),
          const SizedBox(height: 6),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Заголовок форми авторизації.
class AuthFormHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthFormHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
