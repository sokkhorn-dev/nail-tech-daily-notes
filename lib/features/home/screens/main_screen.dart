import 'package:flutter/material.dart';
import 'package:nail_tech_daily_notes/features/home/screens/home_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../profile/screens/profile_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../services/screens/services_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    ServicesScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  final List<String> titles = [
    "Today's Log",
    "My Services",
    "Reports",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[currentIndex],
      ),

      bottomNavigationBar:_BottomTabBar(currentTab: currentIndex, onTabChanged: (i) => setState(() => currentIndex = i),),
    );
  }
}
class _BottomTabBar extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabChanged;
  const _BottomTabBar({required this.currentTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _TabItem(icon: Icons.today_outlined, label: 'Today'),
      _TabItem(icon: Icons.spa_outlined, label: 'Services'),
      _TabItem(icon: Icons.bar_chart_outlined, label: 'Reports'),
      _TabItem(icon: Icons.person_outline, label: 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        color: AppColors.background,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(
          tabs.length,
              (i) => Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tabs[i].icon,
                    size: 22,
                    color: i == currentTab ? AppColors.primary : AppColors.textMuted,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tabs[i].label,
                    style: TextStyle(
                      fontSize: 10,
                      color: i == currentTab ? AppColors.primary : AppColors.textMuted,
                      fontWeight: i == currentTab ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}