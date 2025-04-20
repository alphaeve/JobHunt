import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/providers/auth_provider.dart';

class JobProviderDrawer extends StatelessWidget {
  final int currentIndex;

  const JobProviderDrawer({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Text(
                    user?.name.substring(0, 1) ?? 'U',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name ?? 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.companyName ?? 'Company',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            isSelected: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                Navigator.pushReplacementNamed(context, '/job-provider/home');
              }
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.add_circle_outline,
            title: 'Post a Job',
            isSelected: currentIndex == 1,
            onTap: () {
              if (currentIndex != 1) {
                Navigator.pushReplacementNamed(context, '/job-provider/post-job');
              }
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.work_outline,
            title: 'My Posted Jobs',
            isSelected: currentIndex == 2,
            onTap: () {
              if (currentIndex != 2) {
                Navigator.pushReplacementNamed(context, '/job-provider/my-jobs');
              }
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.business_outlined,
            title: 'Company Profile',
            isSelected: currentIndex == 3,
            onTap: () {
              // TODO: Implement company profile screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'My Account',
            isSelected: currentIndex == 4,
            onTap: () {
              // TODO: Implement account screen
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            isSelected: currentIndex == 5,
            onTap: () {
              // TODO: Implement settings screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            isSelected: currentIndex == 6,
            onTap: () {
              // TODO: Implement help screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            isSelected: false,
            onTap: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.darkGrey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        onTap();
      },
    );
  }
}