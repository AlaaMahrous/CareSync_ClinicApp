class DoctorCardModel {
  final int id;
  final String name;
  final String? imageUrl;
  final String specialization;
  final double consultationFee;
  final double averageRating;

  DoctorCardModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.specialization,
    required this.consultationFee,
    required this.averageRating,
  });

  factory DoctorCardModel.fromJson(Map<String, dynamic> json) {
    return DoctorCardModel(
      id: (json['id'] as num).toInt(),
      name: json['doctor_name'] as String,
      imageUrl: json['image_url'] as String?,
      specialization: json['specialization'] as String,
      consultationFee: (json['consultation_fee'] as num).toDouble(),
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
