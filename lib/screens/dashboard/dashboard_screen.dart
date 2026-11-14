
import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hi everyone 👋',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Social Platform',
                      style: Theme.of(context)
                          .textTheme.headlineMedium,
                    ),
                  ],
                ),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // DASHBOARD BANNER IMAGE
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
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Text(
                            'This Is A social Platform',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'This is A Place Where You Can See Every Thing '
                           ,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Start Learning',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
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

            // MODULE HEADING
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Modules',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // MODULE GRID
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.85,
              children: const [
                ModuleCard(
                  title: 'E-Commerce',
                  subtitle: 'Shopping UI',
                  imagePath: 'assets/images/ecommerce.jpg',
                  color: AppColors.orange,
                ),
                ModuleCard(
                  title: 'Banking',
                  subtitle: 'Finance UI',
                  imagePath: 'assets/images/banking.jpg',
                  color: AppColors.blue,
                ),
                ModuleCard(
                  title: 'Social Media',
                  subtitle: 'Social UI',
                  imagePath: 'assets/images/social_media.jpg',
                  color: AppColors.pink,
                ),
                ModuleCard(
                  title: 'Booking',
                  subtitle: 'Travel UI',
                  imagePath: 'assets/images/booking.jpg',
                  color: AppColors.green,
                ),
              ],
            ),

            const SizedBox(height: 25),

            // LEARNING JOURNEY
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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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

// REUSABLE MODULE CARD WITH IMAGE

class ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;

  const ModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: color.withOpacity(0.12),
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: color,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
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
