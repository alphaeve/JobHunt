import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/user.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/widgets/custom_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole _selectedRole = UserRole.jobSeeker;

  void _continueWithRole() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.setUserRole(_selectedRole);
    
    if (mounted) {
      if (_selectedRole == UserRole.jobSeeker) {
        Navigator.pushReplacementNamed(context, '/job-seeker/home');
      } else {
        Navigator.pushReplacementNamed(context, '/job-provider/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How will you use TalentTrail?',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 16),
              Text(
                'Choose your role to get a personalized experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
              const SizedBox(height: 48),
              _buildRoleCard(
                title: 'Job Seeker',
                description: 'Browse and apply for jobs, track applications, and grow your career',
                icon: Icons.person_search_outlined,
                isSelected: _selectedRole == UserRole.jobSeeker,
                onTap: () {
                  setState(() {
                    _selectedRole = UserRole.jobSeeker;
                  });
                },
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
              _buildRoleCard(
                title: 'Job Provider',
                description: 'Post job opportunities, review applications, and find the perfect talent',
                icon: Icons.business_outlined,
                isSelected: _selectedRole == UserRole.jobProvider,
                onTap: () {
                  setState(() {
                    _selectedRole = UserRole.jobProvider;
                  });
                },
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                onPressed: _continueWithRole,
              ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.darkGrey,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Radio<UserRole>(
              value: title == 'Job Seeker' ? UserRole.jobSeeker : UserRole.jobProvider,
              groupValue: _selectedRole,
              onChanged: (UserRole? value) {
                if (value != null) {
                  setState(() {
                    _selectedRole = value;
                  });
                }
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}