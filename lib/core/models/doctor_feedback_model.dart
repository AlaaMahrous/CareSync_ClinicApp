class DoctorFeedbackModel {
  final String patientName;
  final String comment;
  final int rating;

  DoctorFeedbackModel({
    required this.patientName,
    required this.comment,
    required this.rating,
  });

  factory DoctorFeedbackModel.fromJson(Map<String, dynamic> json) {
    return DoctorFeedbackModel(
      patientName: json['patient_name'],
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}
