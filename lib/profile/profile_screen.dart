
import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget profileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),

            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFFE9E7FF),
                    child: Icon(
                      Icons.person,
                      size: 55,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'DesignMaster Member',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Your All-in-One Digital Platform',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  profileOption(
                    Icons.person_outline,
                    'Personal Information',
                  ),
                  const Divider(height: 1),
                  profileOption(
                    Icons.settings_outlined,
                    'Settings',
                  ),
                  const Divider(height: 1),
                  profileOption(
                    Icons.notifications_outlined,
                    'Notifications',
                  ),
                  const Divider(height: 1),
                  profileOption(
                    Icons.help_outline,
                    'Help & Support',
                  ),
                  const Divider(height: 1),
                  profileOption(
                    Icons.info_outline,
                    'About DesignMaster',
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
