import 'package:flutter/material.dart';

import '../models/lost_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'status_badge.dart';

/// Картка оголошення для стрічки.
/// Підсвічується під курсором миші (вимога до десктопного інтерфейсу).
class ItemCard extends StatefulWidget {
  final LostItem item;
  final VoidCallback? onTap;

  const ItemCard({super.key, required this.item, this.onTap});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isHovered = false;

  void _setHovered(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LostItem item = widget.item;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpacing.normal),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: _isHovered ? AppColors.primary : AppColors.border,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? const [
                    BoxShadow(
                      color: Color(0x1A2E2A6B),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: item.imageColor,
                        borderRadius: BorderRadius.circular(AppSpacing.radius),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 28,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Positioned(
                      top: AppSpacing.small,
                      left: AppSpacing.small,
                      child: StatusBadge(type: item.type),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.normal),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              _InfoRow(icon: Icons.place_outlined, text: item.location),
              const SizedBox(height: AppSpacing.xs),
              _InfoRow(icon: Icons.calendar_today_outlined, text: item.date),
              const SizedBox(height: AppSpacing.normal),
              const Divider(height: 1),
              const SizedBox(height: AppSpacing.small),
              Row(
                children: [
                  Expanded(
                    child: _InfoRow(
                      icon: Icons.visibility_outlined,
                      text: '${item.views} переглядів',
                    ),
                  ),
                  if (_isHovered)
                    const Text(
                      'Детальніше →',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
