import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/application.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/application_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class JobApplicantsScreen extends StatefulWidget {
  const JobApplicantsScreen({super.key});

  @override
  State<JobApplicantsScreen> createState() => _JobApplicantsScreenState();
}

class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  Job? _job;
  List<Application>? _applications;
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadJobAndApplications();
  }

  Future<void> _loadJobAndApplications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final jobId = args?['jobId'];

      if (jobId == null) {
        setState(() {
          _error = 'Job ID is missing';
          _isLoading = false;
        });
        return;
      }

      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      
      final job = await jobProvider.getJobById(jobId);
      if (job == null) {
        setState(() {
          _error = 'Job not found';
          _isLoading = false;
        });
        return;
      }
      
      final applications = await applicationProvider.getApplicationsByJob(jobId);

      setState(() {
        _job = job;
        _applications = applications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load job details: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateApplicationStatus(String applicationId, ApplicationStatus newStatus) async {
    setState(() {
      _isUpdating = true;
    });
    
    try {
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      
      final success = await applicationProvider.updateApplicationStatus(
        applicationId,
        newStatus,
      );
      
      if (success) {
        // Reload applications to show updated status
        _loadJobAndApplications();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Application status updated'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } else {
        throw Exception('Failed to update application status');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  Future<void> _openResume(String? resumeUrl) async {
    if (resumeUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No resume available'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    try {
      final Uri url = Uri.parse(resumeUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception('Could not launch $resumeUrl');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening resume: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading || _isUpdating,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_job?.title ?? 'Job Applicants'),
          elevation: 0,
        ),
        body: _error != null
            ? Center(child: Text(_error!))
            : Column(
                children: [
                  if (_job != null) _buildJobHeader(),
                  Expanded(
                    child: _applications == null || _applications!.isEmpty
                        ? _buildEmptyState()
                        : _buildApplicationsList(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildJobHeader() {
    if (_job == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _job!.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _job!.companyName,
                      style: TextStyle(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${_applications?.length ?? 0} Applicants',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusCount(
                'Pending',
                _getPendingCount(),
                AppColors.warning,
              ),
              _buildStatusCount(
                'Accepted',
                _getAcceptedCount(),
                AppColors.success,
              ),
              _buildStatusCount(
                'Rejected',
                _getRejectedCount(),
                AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCount(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people_outline,
            size: 72,
            color: AppColors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No applicants yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Once someone applies, they\'ll appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsList() {
    if (_applications == null) return const SizedBox.shrink();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _applications!.length,
      itemBuilder: (context, index) {
        final application = _applications![index];
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
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        application.applicantName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            application.applicantName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Applied on ${DateFormat('MMM dd, yyyy').format(application.appliedDate)}',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(application.status),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Cover Letter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  application.coverLetter,
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _openResume(application.resumeUrl),
                      icon: const Icon(Icons.description_outlined),
                      label: const Text('View Resume'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (application.status == ApplicationStatus.pending) ...[
                      IconButton(
                        onPressed: () => _updateApplicationStatus(
                          application.id,
                          ApplicationStatus.rejected,
                        ),
                        icon: const Icon(Icons.close),
                        color: AppColors.error,
                        tooltip: 'Reject',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _updateApplicationStatus(
                          application.id,
                          ApplicationStatus.accepted,
                        ),
                        icon: const Icon(Icons.check),
                        color: AppColors.success,
                        tooltip: 'Accept',
                      ),
                    ],
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

  int _getPendingCount() {
    if (_applications == null) return 0;
    return _applications!
        .where((app) => app.status == ApplicationStatus.pending)
        .length;
  }

  int _getAcceptedCount() {
    if (_applications == null) return 0;
    return _applications!
        .where((app) => app.status == ApplicationStatus.accepted)
        .length;
  }

  int _getRejectedCount() {
    if (_applications == null) return 0;
    return _applications!
        .where((app) => app.status == ApplicationStatus.rejected)
        .length;
  }
}