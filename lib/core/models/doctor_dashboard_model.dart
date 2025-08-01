class DoctorDashboardModel {
  final String fullName;
  final String bio;
  final String imageUrl;
  final int ratingCount;
  final int commentCount;

  DoctorDashboardModel({
    required this.fullName,
    required this.bio,
    required this.imageUrl,
    required this.ratingCount,
    required this.commentCount,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardModel(
      fullName: json['full_name'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['image_url'] ?? '',
      ratingCount: (json['rating_count'] ?? 0) as int,
      commentCount: (json['comment_count'] ?? 0) as int,
    );
  }
}
