import 'package:intl/intl.dart';

enum JobType {
  fullTime,
  partTime,
  internship,
  contract,
  freelance,
}

class Job {
  final String id;
  final String title;
  final String description;
  final String companyId;
  final String companyName;
  final String? companyLogo;
  final String location;
  final double salary;
  final JobType type;
  final String category;
  final DateTime deadline;
  final DateTime postedDate;
  final List<String> skills;
  final int applicationsCount;
  final bool isFeatured;
  final bool isRemote;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.companyId,
    required this.companyName,
    this.companyLogo,
    required this.location,
    required this.salary,
    required this.type,
    required this.category,
    required this.deadline,
    required this.postedDate,
    required this.skills,
    this.applicationsCount = 0,
    this.isFeatured = false,
    this.isRemote = false,
  });

  String get formattedSalary {
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return currencyFormat.format(salary);
  }

  String get formattedPostedDate {
    final Duration difference = DateTime.now().difference(postedDate);
    
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  }

  String get formattedDeadline {
    return DateFormat('MMM dd, yyyy').format(deadline);
  }

  String get jobTypeText {
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

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      location: json['location'],
      salary: json['salary'],
      type: _parseJobType(json['type']),
      category: json['category'],
      deadline: DateTime.parse(json['deadline']),
      postedDate: DateTime.parse(json['postedDate']),
      skills: List<String>.from(json['skills']),
      applicationsCount: json['applicationsCount'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      isRemote: json['isRemote'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'companyId': companyId,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'location': location,
      'salary': salary,
      'type': type.toString().split('.').last,
      'category': category,
      'deadline': deadline.toIso8601String(),
      'postedDate': postedDate.toIso8601String(),
      'skills': skills,
      'applicationsCount': applicationsCount,
      'isFeatured': isFeatured,
      'isRemote': isRemote,
    };
  }

  static JobType _parseJobType(String type) {
    switch (type) {
      case 'fullTime':
        return JobType.fullTime;
      case 'partTime':
        return JobType.partTime;
      case 'internship':
        return JobType.internship;
      case 'contract':
        return JobType.contract;
      case 'freelance':
        return JobType.freelance;
      default:
        return JobType.fullTime;
    }
  }

  Job copyWith({
    String? id,
    String? title,
    String? description,
    String? companyId,
    String? companyName,
    String? companyLogo,
    String? location,
    double? salary,
    JobType? type,
    String? category,
    DateTime? deadline,
    DateTime? postedDate,
    List<String>? skills,
    int? applicationsCount,
    bool? isFeatured,
    bool? isRemote,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      type: type ?? this.type,
      category: category ?? this.category,
      deadline: deadline ?? this.deadline,
      postedDate: postedDate ?? this.postedDate,
      skills: skills ?? this.skills,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isRemote: isRemote ?? this.isRemote,
    );
  }
}