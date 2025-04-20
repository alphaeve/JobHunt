import 'package:flutter/material.dart';
import 'package:talent_trail/models/job.dart';

class JobProvider extends ChangeNotifier {
  final List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Mock data for demo
  JobProvider() {
    _loadMockJobs();
  }

  void _loadMockJobs() {
    _jobs.addAll([
      Job(
        id: '1',
        title: 'Frontend Developer',
        description: 'We are looking for a talented Frontend Developer to join our team. You will be responsible for developing and implementing user interface components using React.js and other frontend technologies.',
        companyId: 'company1',
        companyName: 'Tech Solutions Inc.',
        companyLogo: 'https://randomuser.me/api/portraits/men/1.jpg',
        location: 'San Francisco, CA',
        salary: 90000,
        type: JobType.fullTime,
        category: 'Software Development',
        deadline: DateTime.now().add(const Duration(days: 30)),
        postedDate: DateTime.now().subtract(const Duration(days: 2)),
        skills: ['React', 'JavaScript', 'HTML', 'CSS'],
        isFeatured: true,
      ),
      Job(
        id: '2',
        title: 'UI/UX Design Intern',
        description: 'Join our design team as an intern and gain valuable experience in UI/UX design. You will work closely with senior designers on various projects.',
        companyId: 'company2',
        companyName: 'Creative Designs',
        companyLogo: 'https://randomuser.me/api/portraits/women/2.jpg',
        location: 'New York, NY',
        salary: 50000,
        type: JobType.internship,
        category: 'Design',
        deadline: DateTime.now().add(const Duration(days: 14)),
        postedDate: DateTime.now().subtract(const Duration(days: 5)),
        skills: ['Figma', 'Adobe XD', 'UI Design', 'Prototyping'],
        isFeatured: true,
      ),
      Job(
        id: '3',
        title: 'Backend Developer',
        description: 'We are seeking a skilled Backend Developer to build and maintain our server infrastructure. Experience with Node.js, Express, and MongoDB is required.',
        companyId: 'company3',
        companyName: 'WebTech Solutions',
        companyLogo: 'https://randomuser.me/api/portraits/men/3.jpg',
        location: 'Austin, TX',
        salary: 95000,
        type: JobType.fullTime,
        category: 'Software Development',
        deadline: DateTime.now().add(const Duration(days: 21)),
        postedDate: DateTime.now().subtract(const Duration(days: 1)),
        skills: ['Node.js', 'Express', 'MongoDB', 'API Development'],
      ),
      Job(
        id: '4',
        title: 'Marketing Coordinator',
        description: 'Join our marketing team to help coordinate campaigns and analyze performance metrics. You will work with various stakeholders to ensure successful campaign execution.',
        companyId: 'company4',
        companyName: 'Growth Marketing',
        companyLogo: 'https://randomuser.me/api/portraits/women/4.jpg',
        location: 'Chicago, IL',
        salary: 65000,
        type: JobType.fullTime,
        category: 'Marketing',
        deadline: DateTime.now().add(const Duration(days: 10)),
        postedDate: DateTime.now().subtract(const Duration(days: 7)),
        skills: ['Digital Marketing', 'Analytics', 'Social Media', 'Content Creation'],
      ),
      Job(
        id: '5',
        title: 'Mobile App Developer',
        description: 'Looking for a talented Mobile App Developer to join our team. You will be responsible for developing and maintaining mobile applications for iOS and Android platforms.',
        companyId: 'company5',
        companyName: 'App Innovators',
        companyLogo: 'https://randomuser.me/api/portraits/men/5.jpg',
        location: 'Seattle, WA',
        salary: 85000,
        type: JobType.fullTime,
        category: 'Software Development',
        deadline: DateTime.now().add(const Duration(days: 15)),
        postedDate: DateTime.now().subtract(const Duration(days: 3)),
        skills: ['Flutter', 'React Native', 'iOS', 'Android'],
        isRemote: true,
      ),
    ]);
  }

  Future<List<Job>> getJobs({
    String? category,
    String? location,
    JobType? type,
    double? minSalary,
    bool? isRemote,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Filter jobs based on criteria
      var filteredJobs = List<Job>.from(_jobs);
      
      if (category != null && category.isNotEmpty) {
        filteredJobs = filteredJobs.where(
          (job) => job.category.toLowerCase() == category.toLowerCase()
        ).toList();
      }
      
      if (location != null && location.isNotEmpty) {
        filteredJobs = filteredJobs.where(
          (job) => job.location.toLowerCase().contains(location.toLowerCase())
        ).toList();
      }
      
      if (type != null) {
        filteredJobs = filteredJobs.where(
          (job) => job.type == type
        ).toList();
      }
      
      if (minSalary != null) {
        filteredJobs = filteredJobs.where(
          (job) => job.salary >= minSalary
        ).toList();
      }
      
      if (isRemote != null) {
        filteredJobs = filteredJobs.where(
          (job) => job.isRemote == isRemote
        ).toList();
      }
      
      return filteredJobs;
    } catch (e) {
      _error = 'Failed to load jobs: ${e.toString()}';
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Job>> getFeaturedJobs() async {
    return _jobs.where((job) => job.isFeatured).toList();
  }

  Future<List<Job>> getRecommendedJobs(String userId) async {
    // In a real app, this would use the user's profile data to find matching jobs
    return _jobs.take(3).toList();
  }

  Future<List<Job>> getJobsByCompany(String companyId) async {
    return _jobs.where((job) => job.companyId == companyId).toList();
  }

  Future<Job?> getJobById(String jobId) async {
    try {
      return _jobs.firstWhere((job) => job.id == jobId);
    } catch (e) {
      _error = 'Job not found';
      return null;
    }
  }

  Future<bool> createJob(Job job) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Add the new job
      _jobs.add(job);
      
      return true;
    } catch (e) {
      _error = 'Failed to create job: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateJob(Job updatedJob) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Find and update the job
      final index = _jobs.indexWhere((job) => job.id == updatedJob.id);
      
      if (index != -1) {
        _jobs[index] = updatedJob;
        return true;
      } else {
        _error = 'Job not found';
        return false;
      }
    } catch (e) {
      _error = 'Failed to update job: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteJob(String jobId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Remove the job
      _jobs.removeWhere((job) => job.id == jobId);
      
      return true;
    } catch (e) {
      _error = 'Failed to delete job: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}