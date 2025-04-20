import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/application.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/application_provider.dart';
import 'package:talent_trail/providers/auth_provider.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/custom_button.dart';
import 'package:talent_trail/widgets/loading_overlay.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({super.key});

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _coverLetterController = TextEditingController();
  
  Job? _job;
  bool _isLoading = true;
  String? _error;
  String? _resumePath;
  String? _resumeFileName;
  bool _useExistingResume = true;
  bool _submitting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadJobDetails();
  }

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _loadJobDetails() async {
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

      final job = await Provider.of<JobProvider>(context, listen: false)
          .getJobById(jobId);

      if (job == null) {
        setState(() {
          _error = 'Job not found';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _job = job;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load job details: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _pickResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _resumePath = result.files.single.path;
          _resumeFileName = result.files.single.name;
          _useExistingResume = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_useExistingResume && _resumePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your resume or use your existing one'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _submitting = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      
      final user = authProvider.currentUser!;
      
      // In a real app, we would upload the resume file here
      // For demo, we'll use a mock URL if a file was selected, or the user's existing resume
      final resumeUrl = _useExistingResume 
          ? user.resume 
          : 'https://example.com/${_resumeFileName ?? 'resume.pdf'}';
      
      final application = Application(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        jobId: _job!.id,
        jobTitle: _job!.title,
        companyName: _job!.companyName,
        applicantId: user.id,
        applicantName: user.name,
        resumeUrl: resumeUrl,
        coverLetter: _coverLetterController.text,
        status: ApplicationStatus.pending,
        appliedDate: DateTime.now(),
      );
      
      final success = await applicationProvider.applyForJob(application);
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        
        Navigator.pushReplacementNamed(context, '/job-seeker/my-applications');
      } else {
        throw Exception('Failed to submit application');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _submitting,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Apply for Job'),
          elevation: 0,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : _buildApplicationForm(),
      ),
    );
  }

  Widget _buildApplicationForm() {
    if (_job == null) return const SizedBox.shrink();
    
    final user = Provider.of<AuthProvider>(context).currentUser;
    final hasExistingResume = user?.resume != null;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobHeader()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),
            Text(
              'Resume',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
            const SizedBox(height: 16),
            if (hasExistingResume)
              _buildResumeOption(
                title: 'Use existing resume',
                isSelected: _useExistingResume,
                onTap: () {
                  setState(() {
                    _useExistingResume = true;
                  });
                },
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
            const SizedBox(height: 12),
            _buildResumeOption(
              title: _resumePath != null 
                  ? 'Selected: $_resumeFileName' 
                  : 'Upload a new resume',
              isSelected: !_useExistingResume,
              onTap: () {
                setState(() {
                  _useExistingResume = false;
                });
                if (_resumePath == null) {
                  _pickResume();
                }
              },
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
            if (!_useExistingResume)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: CustomButton(
                  text: _resumePath == null ? 'Select File' : 'Change File',
                  onPressed: _pickResume,
                  backgroundColor: AppColors.secondary,
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
            const SizedBox(height: 24),
            Text(
              'Cover Letter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            const SizedBox(height: 16),
            TextFormField(
              controller: _coverLetterController,
              decoration: InputDecoration(
                hintText: 'Why are you a good fit for this position?',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.lightGrey),
                ),
              ),
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a cover letter';
                }
                if (value.length < 50) {
                  return 'Cover letter should be at least 50 characters';
                }
                return null;
              },
            ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Submit Application',
              onPressed: _submitApplication,
            ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
            const SizedBox(height: 24),
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
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.lightGrey,
            child: _job!.companyLogo != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      _job!.companyLogo!,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    _job!.companyName.substring(0, 1),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _job!.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _job!.companyName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _job!.location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.work_outline,
                      size: 14,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _job!.jobTypeText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected 
                  ? Icons.check_circle 
                  : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : AppColors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}