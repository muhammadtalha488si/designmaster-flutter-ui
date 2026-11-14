
import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../themes/app_colors.dart';
import '../../widgets/module_card.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<String> favoriteIds;
  final ValueChanged<ModuleModel> onModuleTap;
  final ValueChanged<ModuleModel> onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteIds,
    required this.onModuleTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = appModules
        .where((module) => favoriteIds.contains(module.id))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favorites',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your saved modules appear here.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: favorites.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 65,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'No Favorites Yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tap the heart on a module to save it.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final module = favorites[index];

                        return ModuleCard(
                          module: module,
                          isFavorite: true,
                          onFavoriteTap: () => onFavoriteToggle(module),
                          onTap: () => onModuleTap(module),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
