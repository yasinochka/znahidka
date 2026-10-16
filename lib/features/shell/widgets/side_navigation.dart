import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_logo.dart';

/// Опис пункту бічної навігації.
class NavDestination {
  final String label;
  final IconData icon;
  final int badgeCount;

  const NavDestination({
    required this.label,
    required this.icon,
    this.badgeCount = 0,
  });
}

/// Бічна навігація (замість нижньої — для десктопу).
class SideNavigation extends StatelessWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onCreatePressed;

  const SideNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.sidebar,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        AppSpacing.large,
        AppSpacing.medium,
        AppSpacing.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.small),
            child: AppLogo(),
          ),
          const SizedBox(height: AppSpacing.large),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onCreatePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
                ),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Нове оголошення',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          for (int i = 0; i < destinations.length; i++)
            _NavItem(
              destination: destinations[i],
              isSelected: i == selectedIndex,
              onTap: () => onSelected(i),
            ),
          const Spacer(),
          const Divider(color: AppColors.sidebarSelected),
          const SizedBox(height: AppSpacing.normal),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.small),
            child: Text(
              'Швидкі категорії',
              style: TextStyle(fontSize: 12, color: AppColors.textOnDarkMuted),
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          for (final category in MockData.quickCategories)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.small,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.textOnDarkMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.small),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textOnDark,
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

class _NavItem extends StatelessWidget {
  final NavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: isSelected ? AppColors.sidebarSelected : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
        child: InkWell(
          onTap: onTap,
          hoverColor: const Color(0x1FFFFFFF),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.normal,
              vertical: 11,
            ),
            child: Row(
              children: [
                Icon(destination.icon, size: 19, color: AppColors.textOnDark),
                const SizedBox(width: AppSpacing.normal),
                Expanded(
                  child: Text(
                    destination.label,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textOnDark,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (destination.badgeCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${destination.badgeCount}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textOnDark,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
