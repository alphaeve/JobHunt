import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/application.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/application_provider.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/custom_button.dart';
import 'package:talent_trail/widgets/job_provider_drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JobProviderHomeScreen extends StatefulWidget {
  const JobProviderHomeScreen({super.key});

  @override
  State<JobProviderHomeScreen> createState() => _JobProviderHomeScreenState();
}

class _JobProviderHomeScreenState extends State<JobProviderHomeScreen> {
  late Future<List<Job>> _jobsFuture;
  late Future<List<Application>> _applicationsFuture;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final companyId = authProvider.currentUser?.id ?? '';
    
    _jobsFuture = jobProvider.getJobsByCompany(companyId);
    _applicationsFuture = applicationProvider.getApplicationsByUser(companyId);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      drawer: const JobProviderDrawer(currentIndex: 0),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData();
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${user?.name ?? 'there'}!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 600.ms),
              const SizedBox(height: 8),
              Text(
                'Manage your job postings and applications',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkGrey,
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(height: 32),
              _buildQuickStats().animate().fadeIn(delay: 400.ms, duration: 600.ms),
              const SizedBox(height: 32),
              _buildQuickActions().animate().fadeIn(delay: 600.ms, duration: 600.ms),
              const SizedBox(height: 32),
              _buildRecentJobs().animate().fadeIn(delay: 800.ms, duration: 600.ms),
              const SizedBox(height: 32),
              _buildRecentApplications().animate().fadeIn(delay: 1000.ms, duration: 600.ms),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_jobsFuture, _applicationsFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        int totalJobs = 0;
        int totalApplications = 0;
        int pendingApplications = 0;
        
        if (snapshot.hasData) {
          final jobs = snapshot.data![0] as List<Job>;
          final applications = snapshot.data![1] as List<Application>;
          
          totalJobs = jobs.length;
          totalApplications = applications.length;
          pendingApplications = applications
              .where((app) => app.status == ApplicationStatus.pending)
              .length;
        }
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Posted Jobs',
                totalJobs.toString(),
                Icons.work_outline,
              ),
              const VerticalDivider(
                color: Colors.white30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              _buildStatItem(
                'Applications',
                totalApplications.toString(),
                Icons.document_scanner_outlined,
              ),
              const VerticalDivider(
                color: Colors.white30,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              _buildStatItem(
                'Pending',
                pendingApplications.toString(),
                Icons.pending_actions_outlined,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Post a Job',
                Icons.add_circle_outline,
                AppColors.primary,
                onTap: () {
                  Navigator.pushNamed(context, '/job-provider/post-job');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                'View Applications',
                Icons.visibility_outlined,
                AppColors.secondary,
                onTap: () {
                  Navigator.pushNamed(context, '/job-provider/my-jobs');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    {required VoidCallback onTap}
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 36,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Job Postings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/job-provider/my-jobs');
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Job>>(
          future: _jobsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            
            final jobs = snapshot.data ?? [];
            
            if (jobs.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.work_off_outlined,
                      size: 48,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No jobs posted yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create your first job posting',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Post a Job',
                      onPressed: () {
                        Navigator.pushNamed(context, '/job-provider/post-job');
                      },
                    ),
                  ],
                ),
              );
            }
            
            // Only show the 3 most recent jobs
            final recentJobs = jobs.take(3).toList();
            
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentJobs.length,
              itemBuilder: (context, index) {
                final job = recentJobs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      job.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              job.location,
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              job.formattedPostedDate,
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${job.applicationsCount} Applicants',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/job-provider/job-applicants',
                        arguments: {'jobId': job.id},
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentApplications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Applications',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Application>>(
          future: _applicationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            
            final applications = snapshot.data ?? [];
            
            if (applications.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 48,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No applications yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Applications will appear here when candidates apply',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            
            // Only show the 3 most recent applications
            final recentApplications = applications.take(3).toList();
            
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentApplications.length,
              itemBuilder: (context, index) {
                final application = recentApplications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        application.applicantName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      application.applicantName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Applied for ${application.jobTitle}',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: _buildStatusBadge(application.status),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/job-provider/job-applicants',
                        arguments: {'jobId': application.jobId},
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusBadge(ApplicationStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case ApplicationStatus.pending:
        color = AppColors.warning;
        text = 'Pending';
        break;
      case ApplicationStatus.accepted:
        color = AppColors.success;
        text = 'Accepted';
        break;
      case ApplicationStatus.rejected:
        color = AppColors.error;
        text = 'Rejected';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}