
import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../themes/app_colors.dart';

class ModuleDetailScreen extends StatefulWidget {
  final ModuleModel module;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ModuleDetailScreen({
    super.key,
    required this.module,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<ModuleDetailScreen> createState() =>
      _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  late bool favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      favorite = !favorite;
    });
    widget.onFavoriteToggle();
  }

  @override
  Widget build(BuildContext context) {
    final module = widget.module;

    return Scaffold(
      appBar: AppBar(
        title: Text(module.title),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: favorite ? Colors.red : AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                module.imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    child: Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              module.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              module.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            Text(
              'Features & Screens',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            ...module.features.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor:
                          AppColors.primary.withOpacity(0.1),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
