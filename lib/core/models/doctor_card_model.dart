class DoctorCardModel {
  final int id;
  final String fullName;
  final String specialization;
  final double consultationFee;
  final String imageUrl;
  final double averageRating;

  DoctorCardModel({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.consultationFee,
    required this.imageUrl,
    required this.averageRating,
  });

  factory DoctorCardModel.fromJson(Map<String, dynamic> json) {
    final user = json['Users'] ?? {};
    final spec = json['Specializations'] ?? {};
    final rating = json['Doctor_Average_Ratings'];

    return DoctorCardModel(
      id: json['id'],
      fullName: '${user['first_name'] ?? ''} ${user['last_name'] ?? ''}',
      specialization: spec['specialization'] ?? 'Unknown',
      consultationFee: (json['consultation_fee'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      averageRating:
          rating != null ? (rating['average_rating'] as num).toDouble() : 0.0,
    );
  }
}
