import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/config/routes.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/screens/auth/login_screen.dart';
import 'package:talent_trail/screens/job_provider/job_provider_home_screen.dart';
import 'package:talent_trail/screens/job_seeker/job_seeker_home_screen.dart';

class TalentTrailApp extends StatelessWidget {
  const TalentTrailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TalentTrail',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.isAuthenticated) {
            if (authProvider.userRole == UserRole.jobSeeker) {
              return const JobSeekerHomeScreen();
            } else {
              return const JobProviderHomeScreen();
            }
          }
          return const LoginScreen();
        },
      ),
    );
  }
}