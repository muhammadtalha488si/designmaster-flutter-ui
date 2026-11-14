
import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../themes/app_colors.dart';
import '../../widgets/module_card.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<ModuleModel> onModuleTap;
  final Set<String> favoriteIds;
  final ValueChanged<ModuleModel> onFavoriteToggle;
  final VoidCallback onExploreTap;

  const DashboardScreen({
    super.key,
    required this.onModuleTap,
    required this.favoriteIds,
    required this.onFavoriteToggle,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to DesignMaster 👋',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Everything You Need, One Platform.',
                      style:TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person_outline,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Dashboard banner image
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: SizedBox(
                height: 190,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/dashboard_banner.jpg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.95),
                            AppColors.primary.withOpacity(0.55),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           'Your Digital Experience',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                           'Discover banking, shopping, social networking, '
                           'travel and lifestyle services in one place.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Modules',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: onExploreTap,
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            const SizedBox(height: 25),

            Text(
              'Your Learning Journey',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    color: AppColors.primary,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Journey Starts Here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Build your Flutter skills step by step.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
