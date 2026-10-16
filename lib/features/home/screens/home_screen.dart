import 'package:flutter/material.dart';

import '../../../core/data/mock_data.dart';
import '../../../core/models/lost_item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/item_card.dart';
import '../../../core/widgets/stat_card.dart';
import '../widgets/filter_pill.dart';

/// Головна сторінка (ФВ-2): короткі показники, вкладки
/// «Усі / Загублено / Знайдено», фільтри та стрічка оголошень.
/// Дані — hardcoded (MockData), без звернення до сервера.
class HomeScreen extends StatefulWidget {
  final VoidCallback onCreatePressed;

  const HomeScreen({super.key, required this.onCreatePressed});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const String _userName = 'Ліза';

  late final TabController _tabController;

  final Map<String, bool> _filters = {
    'Категорія: усі': false,
    'Львів': true,
    'За тиждень': false,
    'З фото': true,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Відбір оголошень відповідно до вибраної вкладки.
  List<LostItem> get _visibleItems {
    switch (_tabController.index) {
      case 1:
        return MockData.items.where((i) => i.type == ItemType.lost).toList();
      case 2:
        return MockData.items.where((i) => i.type == ItemType.found).toList();
      default:
        return MockData.items;
    }
  }

  void _openItem(LostItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '«${item.title}» — сторінку оголошення буде реалізовано пізніше',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          const SizedBox(height: AppSpacing.large),
          _buildStats(),
          const SizedBox(height: AppSpacing.large),
          _buildToolbar(),
          const SizedBox(height: AppSpacing.medium),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Вітаємо, $_userName!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                'Ось що нового в бюро знахідок вашого міста',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        PrimaryButton(
          label: 'Нове оголошення',
          icon: Icons.add,
          onPressed: widget.onCreatePressed,
        ),
      ],
    );
  }

  Widget _buildStats() {
    return const Row(
      children: [
        Expanded(
          child: StatCard(
            label: 'Нових сьогодні',
            value: '${MockData.newToday}',
            icon: Icons.fiber_new_outlined,
          ),
        ),
        SizedBox(width: AppSpacing.medium),
        Expanded(
          child: StatCard(
            label: 'Загублено',
            value: '1 204',
            icon: Icons.search_off,
            color: AppColors.lost,
          ),
        ),
        SizedBox(width: AppSpacing.medium),
        Expanded(
          child: StatCard(
            label: 'Знайдено',
            value: '986',
            icon: Icons.travel_explore,
            color: AppColors.found,
          ),
        ),
        SizedBox(width: AppSpacing.medium),
        Expanded(
          child: StatCard(
            label: 'Повернуто власникам',
            value: '12 340',
            icon: Icons.volunteer_activism_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        Container(
          width: 330,
          height: 40,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
            border: Border.all(color: AppColors.border),
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            labelColor: AppColors.textOnDark,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(height: 32, text: 'Усі'),
              Tab(height: 32, text: 'Загублено'),
              Tab(height: 32, text: 'Знайдено'),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: Wrap(
            spacing: AppSpacing.small,
            runSpacing: AppSpacing.small,
            children: [
              for (final entry in _filters.entries)
                FilterPill(
                  label: entry.key,
                  isActive: entry.value,
                  onTap: () {
                    setState(() {
                      _filters[entry.key] = !entry.value;
                    });
                  },
                ),
            ],
          ),
        ),
        const Text(
          'Сортувати: ',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const Text(
          'нові',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    final List<LostItem> items = _visibleItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth > 1000 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: AppSpacing.medium,
            crossAxisSpacing: AppSpacing.medium,
            mainAxisExtent: 290,
          ),
          itemBuilder: (context, index) => ItemCard(
            item: items[index],
            onTap: () => _openItem(items[index]),
          ),
        );
      },
    );
  }
}
