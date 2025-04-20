enum UserRole {
  jobSeeker,
  jobProvider,
}

class User {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String? profilePicture;
  final String? phone;
  final String? location;
  final String? bio;
  final String? resume; // URL to resume for job seekers
  final String? companyName; // For job providers
  final String? companyWebsite; // For job providers
  final String? companyLogo; // For job providers

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profilePicture,
    this.phone,
    this.location,
    this.bio,
    this.resume,
    this.companyName,
    this.companyWebsite,
    this.companyLogo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'] == 'jobSeeker' ? UserRole.jobSeeker : UserRole.jobProvider,
      profilePicture: json['profilePicture'],
      phone: json['phone'],
      location: json['location'],
      bio: json['bio'],
      resume: json['resume'],
      companyName: json['companyName'],
      companyWebsite: json['companyWebsite'],
      companyLogo: json['companyLogo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role == UserRole.jobSeeker ? 'jobSeeker' : 'jobProvider',
      'profilePicture': profilePicture,
      'phone': phone,
      'location': location,
      'bio': bio,
      'resume': resume,
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyLogo': companyLogo,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    String? profilePicture,
    String? phone,
    String? location,
    String? bio,
    String? resume,
    String? companyName,
    String? companyWebsite,
    String? companyLogo,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      resume: resume ?? this.resume,
      companyName: companyName ?? this.companyName,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      companyLogo: companyLogo ?? this.companyLogo,
    );
  }
}