import 'package:flutter/material.dart';

import '../../home/screens/home_screen.dart';
import '../../placeholder/screens/placeholder_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../widgets/side_navigation.dart';
import '../widgets/top_bar.dart';

/// Каркас застосунку після входу: бічна навігація + верхня панель +
/// вміст вибраного розділу.
class AppShell extends StatefulWidget {
  final int initialIndex;

  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const int _notificationsIndex = 2;
  static const int _profileIndex = 3;

  static const List<NavDestination> _destinations = [
    NavDestination(label: 'Головна', icon: Icons.home_outlined),
    NavDestination(label: 'Мої оголошення', icon: Icons.view_list_outlined),
    NavDestination(
      label: 'Сповіщення',
      icon: Icons.notifications_none,
      badgeCount: 3,
    ),
    NavDestination(label: 'Профіль', icon: Icons.person_outline),
  ];

  static const List<String> _titles = [
    'Оголошення',
    'Мої оголошення',
    'Сповіщення',
    'Профіль',
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _select(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showNotImplemented() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Екран буде реалізовано в наступних лабораторних роботах'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigation(
            destinations: _destinations,
            selectedIndex: _selectedIndex,
            onSelected: _select,
            onCreatePressed: _showNotImplemented,
          ),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  title: _titles[_selectedIndex],
                  showSearch: _selectedIndex <= 1,
                  onProfileTap: () => _select(_profileIndex),
                  onNotificationsTap: () => _select(_notificationsIndex),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      HomeScreen(onCreatePressed: _showNotImplemented),
                      const PlaceholderScreen(
                        icon: Icons.view_list_outlined,
                        title: 'Мої оголошення',
                      ),
                      const PlaceholderScreen(
                        icon: Icons.notifications_none,
                        title: 'Сповіщення',
                      ),
                      const ProfileScreen(),
                    ],
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
