import 'package:flutter/material.dart';
import 'package:talent_trail/models/application.dart';

class ApplicationProvider extends ChangeNotifier {
  final List<Application> _applications = [];
  bool _isLoading = false;
  String? _error;

  List<Application> get applications => _applications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Mock data for demo
  ApplicationProvider() {
    _loadMockApplications();
  }

  void _loadMockApplications() {
    _applications.addAll([
      Application(
        id: '1',
        jobId: '1',
        jobTitle: 'Frontend Developer',
        companyName: 'Tech Solutions Inc.',
        applicantId: '1',
        applicantName: 'John Doe',
        resumeUrl: 'https://example.com/resume.pdf',
        coverLetter: 'I am excited to apply for the Frontend Developer position at Tech Solutions Inc. With over 5 years of experience in React.js development, I believe I am a strong candidate for this role.',
        status: ApplicationStatus.pending,
        appliedDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Application(
        id: '2',
        jobId: '2',
        jobTitle: 'UI/UX Design Intern',
        companyName: 'Creative Designs',
        applicantId: '1',
        applicantName: 'John Doe',
        resumeUrl: 'https://example.com/resume.pdf',
        coverLetter: 'I am a design student looking to gain practical experience in UI/UX design. I would love to bring my creativity and enthusiasm to Creative Designs as an intern.',
        status: ApplicationStatus.accepted,
        appliedDate: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Application(
        id: '3',
        jobId: '3',
        jobTitle: 'Backend Developer',
        companyName: 'WebTech Solutions',
        applicantId: '1',
        applicantName: 'John Doe',
        resumeUrl: 'https://example.com/resume.pdf',
        coverLetter: 'I am applying for the Backend Developer position at WebTech Solutions. I have extensive experience with Node.js, Express, and MongoDB, and I am confident that I would be a valuable addition to your team.',
        status: ApplicationStatus.rejected,
        appliedDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ]);
  }

  Future<List<Application>> getApplicationsByUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Get applications for the user
      return _applications.where((app) => app.applicantId == userId).toList();
    } catch (e) {
      _error = 'Failed to load applications: ${e.toString()}';
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Application>> getApplicationsByJob(String jobId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Get applications for the job
      return _applications.where((app) => app.jobId == jobId).toList();
    } catch (e) {
      _error = 'Failed to load applications: ${e.toString()}';
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> applyForJob(Application application) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Add the new application
      _applications.add(application);
      
      return true;
    } catch (e) {
      _error = 'Failed to apply for job: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateApplicationStatus(
    String applicationId,
    ApplicationStatus status
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Find and update the application
      final index = _applications.indexWhere((app) => app.id == applicationId);
      
      if (index != -1) {
        _applications[index] = _applications[index].copyWith(status: status);
        return true;
      } else {
        _error = 'Application not found';
        return false;
      }
    } catch (e) {
      _error = 'Failed to update application status: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  int countApplicationsByStatus(
    List<Application> applications,
    ApplicationStatus status
  ) {
    return applications.where((app) => app.status == status).length;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}