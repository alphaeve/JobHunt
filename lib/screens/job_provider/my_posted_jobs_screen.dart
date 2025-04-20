import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/custom_button.dart';
import 'package:talent_trail/widgets/job_provider_drawer.dart';
import 'package:talent_trail/widgets/loading_overlay.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyPostedJobsScreen extends StatefulWidget {
  const MyPostedJobsScreen({super.key});

  @override
  State<MyPostedJobsScreen> createState() => _MyPostedJobsScreenState();
}

class _MyPostedJobsScreenState extends State<MyPostedJobsScreen> {
  late Future<List<Job>> _jobsFuture;
  bool _isLoading = false;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }
  
  void _loadJobs() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final companyId = authProvider.currentUser?.id ?? '';
    
    _jobsFuture = jobProvider.getJobsByCompany(companyId);
  }
  
  Future<void> _deleteJob(String jobId) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      
      final success = await jobProvider.deleteJob(jobId);
      
      if (success) {
        _loadJobs();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Job deleted successfully'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } else {
        throw Exception('Failed to delete job');
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to delete job: $e';
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $_error'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _confirmDeleteJob(String jobId, String jobTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: Text('Are you sure you want to delete "$jobTitle"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteJob(jobId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Posted Jobs'),
          elevation: 0,
        ),
        drawer: const JobProviderDrawer(currentIndex: 2),
        body: RefreshIndicator(
          onRefresh: () async {
            _loadJobs();
            setState(() {});
          },
          child: FutureBuilder<List<Job>>(
            future: _jobsFuture,
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
                        'No jobs posted yet',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start posting jobs to find talent',
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
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  job.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              if (job.isFeatured)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Featured',
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                job.location,
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              if (job.isRemote) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Remote',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.work_outline,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                job.jobTypeText,
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.attach_money,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                job.formattedSalary,
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Posted ${job.formattedPostedDate}',
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.event,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Deadline: ${job.formattedDeadline}',
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.people_outline,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Applications',
                                      style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${job.applicationsCount} candidates',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/job-provider/job-applicants',
                                      arguments: {'jobId': job.id},
                                    );
                                  },
                                  child: const Text('View'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/job-provider/edit-job',
                                      arguments: {'jobId': job.id},
                                    );
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                  label: const Text('Edit'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    _confirmDeleteJob(job.id, job.title);
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                  label: const Text('Delete'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    foregroundColor: AppColors.error,
                                    side: BorderSide(color: AppColors.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                    .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 400.ms)
                    .slideY(begin: 0.1, end: 0);
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/job-provider/post-job');
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add),
          label: const Text('Post a Job'),
        ),
      ),
    );
  }
}