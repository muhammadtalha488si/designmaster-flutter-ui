
import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../themes/app_colors.dart';
import '../../widgets/module_card.dart';

class ExploreScreen extends StatelessWidget {
  final ValueChanged<ModuleModel> onModuleTap;
  final Set<String> favoriteIds;
  final ValueChanged<ModuleModel> onFavoriteToggle;

  const ExploreScreen({
    super.key,
    required this.onModuleTap,
    required this.favoriteIds,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Discover all DesignMaster modules.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: GridView.builder(
                itemCount: appModules.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final module = appModules[index];

                  return ModuleCard(
                    module: module,
                    isFavorite: favoriteIds.contains(module.id),
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
