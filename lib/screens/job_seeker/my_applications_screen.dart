import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/application.dart';
import 'package:talent_trail/providers/application_provider.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/widgets/application_card.dart';
import 'package:talent_trail/widgets/job_seeker_bottom_nav.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Application>> _applicationsFuture;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadApplications();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  void _loadApplications() {
    final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    _applicationsFuture = applicationProvider.getApplicationsByUser(
      authProvider.currentUser?.id ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildApplicationsList(null),
          _buildApplicationsList(ApplicationStatus.pending),
          _buildApplicationsList(ApplicationStatus.accepted),
        ],
      ),
      bottomNavigationBar: const JobSeekerBottomNav(currentIndex: 2),
    );
  }

  Widget _buildApplicationsList(ApplicationStatus? filterStatus) {
    return FutureBuilder<List<Application>>(
      future: _applicationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        
        final applications = snapshot.data ?? [];
        
        // Apply filter if specified
        final filteredApplications = filterStatus != null
            ? applications.where((app) => app.status == filterStatus).toList()
            : applications;
        
        if (filteredApplications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.work_off_outlined,
                  size: 72,
                  color: AppColors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  filterStatus == null
                      ? 'No applications yet'
                      : filterStatus == ApplicationStatus.pending
                          ? 'No pending applications'
                          : 'No accepted applications',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  filterStatus == null
                      ? 'Start applying for jobs!'
                      : 'Check other tabs or apply for more jobs',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/job-seeker/jobs');
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Find Jobs'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredApplications.length,
          itemBuilder: (context, index) {
            return ApplicationCard(
              application: filteredApplications[index],
            ).animate().fadeIn(
              delay: Duration(milliseconds: 100 * index),
              duration: 400.ms,
            ).slideY(begin: 0.1, end: 0);
          },
        );
      },
    );
  }
}