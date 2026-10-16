import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Логотип застосунку «Знахідка».
class AppLogo extends StatelessWidget {
  /// true — для темного фону (бічна панель, екрани авторизації).
  final bool onDark;

  const AppLogo({super.key, this.onDark = true});

  @override
  Widget build(BuildContext context) {
    final Color titleColor = onDark ? AppColors.textOnDark : AppColors.textPrimary;
    final Color subtitleColor =
        onDark ? AppColors.textOnDarkMuted : AppColors.textSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: onDark ? AppColors.surface : AppColors.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            Icons.verified_user_outlined,
            size: 20,
            color: onDark ? AppColors.primary : AppColors.textOnDark,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Знахідка',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
              Text(
                'бюро знахідок онлайн',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: subtitleColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
