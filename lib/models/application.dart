enum ApplicationStatus {
  pending,
  accepted,
  rejected,
}

class Application {
  final String id;
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String applicantId;
  final String applicantName;
  final String? resumeUrl;
  final String coverLetter;
  final ApplicationStatus status;
  final DateTime appliedDate;

  Application({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.applicantId,
    required this.applicantName,
    this.resumeUrl,
    required this.coverLetter,
    required this.status,
    required this.appliedDate,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      jobId: json['jobId'],
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      applicantId: json['applicantId'],
      applicantName: json['applicantName'],
      resumeUrl: json['resumeUrl'],
      coverLetter: json['coverLetter'],
      status: _parseApplicationStatus(json['status']),
      appliedDate: DateTime.parse(json['appliedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'applicantId': applicantId,
      'applicantName': applicantName,
      'resumeUrl': resumeUrl,
      'coverLetter': coverLetter,
      'status': status.toString().split('.').last,
      'appliedDate': appliedDate.toIso8601String(),
    };
  }

  static ApplicationStatus _parseApplicationStatus(String status) {
    switch (status) {
      case 'pending':
        return ApplicationStatus.pending;
      case 'accepted':
        return ApplicationStatus.accepted;
      case 'rejected':
        return ApplicationStatus.rejected;
      default:
        return ApplicationStatus.pending;
    }
  }

  Application copyWith({
    String? id,
    String? jobId,
    String? jobTitle,
    String? companyName,
    String? applicantId,
    String? applicantName,
    String? resumeUrl,
    String? coverLetter,
    ApplicationStatus? status,
    DateTime? appliedDate,
  }) {
    return Application(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      applicantId: applicantId ?? this.applicantId,
      applicantName: applicantName ?? this.applicantName,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      coverLetter: coverLetter ?? this.coverLetter,
      status: status ?? this.status,
      appliedDate: appliedDate ?? this.appliedDate,
    );
  }
}