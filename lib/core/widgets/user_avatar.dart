import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Кругла аватарка з ініціалами користувача.
class UserAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const UserAvatar({super.key, required this.initials, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.textOnDark,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
