import 'package:flutter/material.dart';
import 'package:talent_trail/config/theme.dart';

class JobSeekerBottomNav extends StatelessWidget {
  final int currentIndex;

  const JobSeekerBottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacementNamed(context, '/job-seeker/home');
                  }
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.search_outlined,
                label: 'Jobs',
                isSelected: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) {
                    Navigator.pushReplacementNamed(context, '/job-seeker/jobs');
                  }
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.work_outline,
                label: 'Applications',
                isSelected: currentIndex == 2,
                onTap: () {
                  if (currentIndex != 2) {
                    Navigator.pushReplacementNamed(context, '/job-seeker/my-applications');
                  }
                },
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () {
                  // TODO: Implement profile screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.darkGrey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.darkGrey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}