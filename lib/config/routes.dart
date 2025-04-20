import 'package:flutter/material.dart';
import 'package:talent_trail/screens/auth/login_screen.dart';
import 'package:talent_trail/screens/auth/signup_screen.dart';
import 'package:talent_trail/screens/auth/role_selection_screen.dart';
import 'package:talent_trail/screens/job_seeker/job_seeker_home_screen.dart';
import 'package:talent_trail/screens/job_seeker/job_listing_screen.dart';
import 'package:talent_trail/screens/job_seeker/job_detail_screen.dart';
import 'package:talent_trail/screens/job_seeker/apply_job_screen.dart';
import 'package:talent_trail/screens/job_seeker/my_applications_screen.dart';
import 'package:talent_trail/screens/job_provider/job_provider_home_screen.dart';
import 'package:talent_trail/screens/job_provider/post_job_screen.dart';
import 'package:talent_trail/screens/job_provider/my_posted_jobs_screen.dart';
import 'package:talent_trail/screens/job_provider/edit_job_screen.dart';
import 'package:talent_trail/screens/job_provider/job_applicants_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/role-selection': (context) => const RoleSelectionScreen(),
    
    // Job Seeker Routes
    '/job-seeker/home': (context) => const JobSeekerHomeScreen(),
    '/job-seeker/jobs': (context) => const JobListingScreen(),
    '/job-seeker/job-details': (context) => const JobDetailScreen(),
    '/job-seeker/apply-job': (context) => const ApplyJobScreen(),
    '/job-seeker/my-applications': (context) => const MyApplicationsScreen(),
    
    // Job Provider Routes
    '/job-provider/home': (context) => const JobProviderHomeScreen(),
    '/job-provider/post-job': (context) => const PostJobScreen(),
    '/job-provider/my-jobs': (context) => const MyPostedJobsScreen(),
    '/job-provider/edit-job': (context) => const EditJobScreen(),
    '/job-provider/job-applicants': (context) => const JobApplicantsScreen(),
  };
}