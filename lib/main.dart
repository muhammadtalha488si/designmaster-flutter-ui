import 'package:flutter/material.dart';

import 'package:designmaster_flutter_ui/explore/explore_screen.dart';
import 'package:designmaster_flutter_ui/favorites/favorites_screen.dart';
import 'package:designmaster_flutter_ui/models/module_detail_screen.dart';
import 'package:designmaster_flutter_ui/profile/profile_screen.dart';
import 'package:designmaster_flutter_ui/screens/dashboard/dashbord_screen.dart';
import 'package:designmaster_flutter_ui/screens/ecommerce/ecommerce_home_screen.dart';
import 'package:designmaster_flutter_ui/providers/cart_provider.dart';
import 'package:designmaster_flutter_ui/screens/banking/banking_home_screen.dart';
import 'package:designmaster_flutter_ui/screens/social/social_media_home_screen.dart';
import 'package:designmaster_flutter_ui/screens/booking/booking_home_screen.dart';

import 'models/module_model.dart';
import 'themes/app_theme.dart';
import 'widgets/bottom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved Cart and Wishlist data before opening the app.
  await CartProvider().initialize();

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
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final Set<String> favoriteIds = {};

  void toggleFavorite(ModuleModel module) {
    setState(() {
      if (favoriteIds.contains(module.id)) {
        favoriteIds.remove(module.id);
      } else {
        favoriteIds.add(module.id);
      }
    });
  }

  void openModule(ModuleModel module) {
    // Open Banking module.
    if (module.id == 'banking') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BankingHomeScreen()),
      );
      return;
    }

    // Open Social Media module.
    if (module.id == 'social') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialMediaHomeScreen()));
      return;
    }

    // Open Booking module.
    if (module.id == 'booking') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingHomeScreen()));
      return;
    }

    // Open E-Commerce module.
    if (module.id == 'ecommerce') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EcommerceHomeScreen()),
      );

      return;
    }

    // Existing navigation for other modules.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModuleDetailScreen(
          module: module,
          isFavorite: favoriteIds.contains(module.id),
          onFavoriteToggle: () => toggleFavorite(module),
        ),
      ),
    );
  }

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        onModuleTap: openModule,
        favoriteIds: favoriteIds,
        onFavoriteToggle: toggleFavorite,
        onExploreTap: () => changeTab(1),
      ),

      ExploreScreen(
        onModuleTap: openModule,
        favoriteIds: favoriteIds,
        onFavoriteToggle: toggleFavorite,
      ),

      FavoritesScreen(
        favoriteIds: favoriteIds,
        onModuleTap: openModule,
        onFavoriteToggle: toggleFavorite,
      ),

      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),

      bottomNavigationBar: AppBottomNavigation(
        currentIndex: selectedIndex,
        onTap: changeTab,
      ),
    );
  }
}
