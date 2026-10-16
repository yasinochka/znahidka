import 'package:flutter/material.dart';

import '../models/lost_item.dart';
import '../theme/app_colors.dart';

/// Мітка типу оголошення: «Загублено» або «Знайдено».
class StatusBadge extends StatelessWidget {
  final ItemType type;

  const StatusBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final bool isLost = type == ItemType.lost;
    final Color color = isLost ? AppColors.lost : AppColors.found;
    final Color background =
        isLost ? AppColors.lostBackground : AppColors.foundBackground;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            isLost ? 'Загублено' : 'Знайдено',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
