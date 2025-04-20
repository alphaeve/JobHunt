import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/job_card.dart';
import 'package:talent_trail/widgets/job_filter_bottom_sheet.dart';
import 'package:talent_trail/widgets/job_seeker_bottom_nav.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({super.key});

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  final _searchController = TextEditingController();
  late Future<List<Job>> _jobsFuture;
  Map<String, dynamic> _filters = {};
  
  @override
  void initState() {
    super.initState();
    _loadJobs();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Check if we have filters from route arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args.containsKey('filter') && args['filter'] == 'internship') {
        _filters['type'] = JobType.internship;
      }
      if (args.containsKey('category')) {
        _filters['category'] = args['category'];
      }
      _loadJobs();
    }
  }
  
  void _loadJobs() {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    _jobsFuture = jobProvider.getJobs(
      category: _filters['category'],
      location: _filters['location'],
      type: _filters['type'],
      minSalary: _filters['minSalary'],
      isRemote: _filters['isRemote'],
    );
  }
  
  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _filters = filters;
      _loadJobs();
    });
  }
  
  void _resetFilters() {
    setState(() {
      _filters = {};
      _loadJobs();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Jobs'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => JobFilterBottomSheet(
                  initialFilters: _filters,
                  onApplyFilters: _applyFilters,
                  onResetFilters: _resetFilters,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          if (_filters.isNotEmpty) _buildActiveFilters(),
          Expanded(
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
                          Icons.search_off,
                          size: 72,
                          color: AppColors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No jobs found',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (_filters.isNotEmpty)
                          ElevatedButton(
                            onPressed: _resetFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text('Reset Filters'),
                          ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
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
                      delay: Duration(milliseconds: 100 * index),
                      duration: 400.ms,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const JobSeekerBottomNav(currentIndex: 1),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search jobs, companies...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onSubmitted: (value) {
          // TODO: Implement search
        },
      ),
    );
  }

  Widget _buildActiveFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Filters',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextButton(
                onPressed: _resetFilters,
                child: const Text('Reset All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_filters['category'] != null)
                _buildFilterChip(
                  'Category: ${_filters['category']}',
                  onRemove: () {
                    setState(() {
                      _filters.remove('category');
                      _loadJobs();
                    });
                  },
                ),
              if (_filters['location'] != null)
                _buildFilterChip(
                  'Location: ${_filters['location']}',
                  onRemove: () {
                    setState(() {
                      _filters.remove('location');
                      _loadJobs();
                    });
                  },
                ),
              if (_filters['type'] != null)
                _buildFilterChip(
                  'Type: ${_jobTypeToString(_filters['type'])}',
                  onRemove: () {
                    setState(() {
                      _filters.remove('type');
                      _loadJobs();
                    });
                  },
                ),
              if (_filters['minSalary'] != null)
                _buildFilterChip(
                  'Min Salary: \$${_filters['minSalary']}',
                  onRemove: () {
                    setState(() {
                      _filters.remove('minSalary');
                      _loadJobs();
                    });
                  },
                ),
              if (_filters['isRemote'] == true)
                _buildFilterChip(
                  'Remote Only',
                  onRemove: () {
                    setState(() {
                      _filters.remove('isRemote');
                      _loadJobs();
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close,
              color: AppColors.primary,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _jobTypeToString(JobType type) {
    switch (type) {
      case JobType.fullTime:
        return 'Full-time';
      case JobType.partTime:
        return 'Part-time';
      case JobType.internship:
        return 'Internship';
      case JobType.contract:
        return 'Contract';
      case JobType.freelance:
        return 'Freelance';
    }
  }
}