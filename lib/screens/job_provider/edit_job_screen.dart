import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/providers/job_provider.dart';
import 'package:talent_trail/widgets/custom_button.dart';
import 'package:talent_trail/widgets/loading_overlay.dart';
import 'package:intl/intl.dart';

class EditJobScreen extends StatefulWidget {
  const EditJobScreen({super.key});

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _categoryController = TextEditingController();
  final _skillsController = TextEditingController();
  
  late DateTime _deadline;
  late JobType _jobType;
  late bool _isRemote;
  late bool _isFeatured;
  
  Job? _job;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadJobDetails();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _categoryController.dispose();
    _skillsController.dispose();
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

      // Initialize form with job data
      _titleController.text = job.title;
      _descriptionController.text = job.description;
      _locationController.text = job.location;
      _salaryController.text = job.salary.toString();
      _categoryController.text = job.category;
      _skillsController.text = job.skills.join(', ');
      
      setState(() {
        _job = job;
        _deadline = job.deadline;
        _jobType = job.type;
        _isRemote = job.isRemote;
        _isFeatured = job.isFeatured;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load job details: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateJob() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isSaving = true;
    });
    
    try {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      
      if (_job == null) {
        throw Exception('Job not found');
      }
      
      final updatedJob = _job!.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        salary: double.parse(_salaryController.text),
        category: _categoryController.text,
        type: _jobType,
        deadline: _deadline,
        skills: _skillsController.text.split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList(),
        isRemote: _isRemote,
        isFeatured: _isFeatured,
      );
      
      final success = await jobProvider.updateJob(updatedJob);
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Job updated successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        
        Navigator.pop(context);
      } else {
        throw Exception('Failed to update job');
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
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _selectDeadline() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDate != null) {
      setState(() {
        _deadline = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading || _isSaving,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Job'),
          elevation: 0,
        ),
        body: _error != null
            ? Center(child: Text(_error!))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Job Details',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        controller: _titleController,
                        label: 'Job Title',
                        hint: 'e.g., Frontend Developer',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Job Description',
                        hint: 'Describe the job responsibilities, requirements, etc.',
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job description';
                          }
                          if (value.length < 50) {
                            return 'Description should be at least 50 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _categoryController,
                        label: 'Job Category',
                        hint: 'e.g., Software Development, Design, Marketing',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildJobTypeSelector(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _locationController,
                        label: 'Job Location',
                        hint: 'e.g., San Francisco, CA',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildRemoteOption(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _salaryController,
                        label: 'Salary (USD)',
                        hint: 'e.g., 80000',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a salary';
                          }
                          try {
                            double.parse(value);
                            return null;
                          } catch (e) {
                            return 'Please enter a valid number';
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildDeadlineSelector(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _skillsController,
                        label: 'Required Skills',
                        hint: 'e.g., React, JavaScript, UI/UX (comma separated)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter required skills';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildFeaturedOption(),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'Update Job',
                        onPressed: _updateJob,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.lightGrey),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildJobTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: DropdownButton<JobType>(
            value: _jobType,
            isExpanded: true,
            underline: const SizedBox(),
            items: JobType.values.map((JobType type) {
              return DropdownMenuItem<JobType>(
                value: type,
                child: Text(_jobTypeToString(type)),
              );
            }).toList(),
            onChanged: (JobType? newValue) {
              if (newValue != null) {
                setState(() {
                  _jobType = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRemoteOption() {
    return Row(
      children: [
        Checkbox(
          value: _isRemote,
          onChanged: (value) {
            setState(() {
              _isRemote = value ?? false;
            });
          },
          activeColor: AppColors.primary,
        ),
        const Text('This is a remote position'),
      ],
    );
  }

  Widget _buildFeaturedOption() {
    return Row(
      children: [
        Checkbox(
          value: _isFeatured,
          onChanged: (value) {
            setState(() {
              _isFeatured = value ?? false;
            });
          },
          activeColor: AppColors.primary,
        ),
        const Text('Feature this job (highlighted in search results)'),
      ],
    );
  }

  Widget _buildDeadlineSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Application Deadline',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDeadline,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMMM dd, yyyy').format(_deadline),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
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