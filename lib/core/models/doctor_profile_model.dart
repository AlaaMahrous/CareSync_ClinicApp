class DoctorProfileModel {
  final int id;
  final String info;
  final String doctorName;
  final String? imageUrl;
  final String specialization;
  final double consultationFee;
  final double averageRating;
  final String phone;
  final String address;
  final double experience;

  DoctorProfileModel({
    required this.id,
    required this.info,
    required this.doctorName,
    this.imageUrl,
    required this.specialization,
    required this.consultationFee,
    required this.averageRating,
    required this.phone,
    required this.address,
    required this.experience,
  });

  factory DoctorProfileModel.fromMap(Map<String, dynamic> map) {
    return DoctorProfileModel(
      id: map['id'] as int,
      info: map['info'] ?? '',
      doctorName: map['doctor_name'] ?? '',
      imageUrl: map['image_url'] ?? '',
      specialization: map['specialization'] ?? '',
      consultationFee: (map['consultation_fee'] as num?)?.toDouble() ?? 0.0,
      averageRating: (map['average_rating'] as num?)?.toDouble() ?? 0.0,
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      experience: (map['experience'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
