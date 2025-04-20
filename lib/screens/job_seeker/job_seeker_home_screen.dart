import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/featured_job_card.dart';
import 'package:talent_trail/widgets/job_card.dart';
import 'package:talent_trail/widgets/job_seeker_bottom_nav.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JobSeekerHomeScreen extends StatefulWidget {
  const JobSeekerHomeScreen({super.key});

  @override
  State<JobSeekerHomeScreen> createState() => _JobSeekerHomeScreenState();
}

class _JobSeekerHomeScreenState extends State<JobSeekerHomeScreen> {
  late Future<List<Job>> _featuredJobsFuture;
  late Future<List<Job>> _recommendedJobsFuture;
  
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }
  
  void _loadJobs() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    _featuredJobsFuture = jobProvider.getFeaturedJobs();
    _recommendedJobsFuture = jobProvider.getRecommendedJobs(authProvider.currentUser?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primaryDark, AppColors.primary],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${user?.name?.split(' ').first ?? 'there'}!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find your dream job today',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/job-seeker/jobs');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.darkGrey,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Search for jobs, companies...',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      'Featured Internships',
                      onSeeAllPressed: () {
                        Navigator.pushNamed(
                          context, 
                          '/job-seeker/jobs',
                          arguments: {'filter': 'internship'},
                        );
                      },
                    ).animate().fadeIn(duration: 600.ms),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: FutureBuilder<List<Job>>(
                        future: _featuredJobsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          
                          final jobs = snapshot.data ?? [];
                          if (jobs.isEmpty) {
                            return const Center(
                              child: Text('No featured jobs found'),
                            );
                          }
                          
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 0 : 16,
                                  right: index == jobs.length - 1 ? 0 : 0,
                                ),
                                child: FeaturedJobCard(
                                  job: jobs[index],
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/job-seeker/job-details',
                                      arguments: {'jobId': jobs[index].id},
                                    );
                                  },
                                ),
                              ).animate().fadeIn(
                                delay: Duration(milliseconds: 100 * index),
                                duration: 600.ms,
                              ).slideX(begin: 0.2, end: 0);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionHeader(
                      'Recommended Jobs',
                      onSeeAllPressed: () {
                        Navigator.pushNamed(context, '/job-seeker/jobs');
                      },
                    ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                    const SizedBox(height: 16),
                    FutureBuilder<List<Job>>(
                      future: _recommendedJobsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        
                        if (snapshot.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text('Error: ${snapshot.error}'),
                            ),
                          );
                        }
                        
                        final jobs = snapshot.data ?? [];
                        if (jobs.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text('No recommended jobs found'),
                            ),
                          );
                        }
                        
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: jobs.length,
                          itemBuilder: (context, index) {
                            return JobCard(
                              job: jobs[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/job-seeker/job-details',
                                  arguments: {'jobId': jobs[index].id},
                                );
                              },
                            ).animate().fadeIn(
                              delay: Duration(milliseconds: 400 + (100 * index)),
                              duration: 600.ms,
                            ).slideY(begin: 0.2, end: 0);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildBrowseByCategory().animate().fadeIn(delay: 500.ms, duration: 600.ms),
                    const SizedBox(height: 100), // Space for bottom navigation
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: const JobSeekerBottomNav(currentIndex: 0),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            'See All',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrowseByCategory() {
    final categories = [
      {'name': 'Technology', 'icon': Icons.computer},
      {'name': 'Design', 'icon': Icons.design_services},
      {'name': 'Marketing', 'icon': Icons.trending_up},
      {'name': 'Finance', 'icon': Icons.attach_money},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse by Category',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/job-seeker/jobs',
                  arguments: {'category': categories[index]['name']},
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        categories[index]['icon'] as IconData,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        categories[index]['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}