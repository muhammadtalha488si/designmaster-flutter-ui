import 'package:flutter/material.dart';

import 'themes/app_theme.dart';
import 'themes/app_colors.dart';

import 'screens/dashboard/dashboard_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(const DesignMasterApp());
}

class DesignMasterApp extends StatelessWidget {
  const DesignMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'DesignMaster',

      theme: AppTheme.lightTheme,

      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),

    const PlaceholderScreen(
      title: 'Explore',
      icon: Icons.explore_outlined,
    ),

    const PlaceholderScreen(
      title: 'Favorites',
      icon: Icons.favorite_outline,
    ),

    const PlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: AppBottomNavigation(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 65,
              color: AppColors.primary,
            ),

            const SizedBox(height: 15),

            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            const Text(
              'Coming Soon',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}