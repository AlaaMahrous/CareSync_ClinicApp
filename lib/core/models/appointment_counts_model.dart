class AppointmentCountsModel {
  final int availableCount;
  final int bookedCount;

  AppointmentCountsModel({
    required this.availableCount,
    required this.bookedCount,
  });

  factory AppointmentCountsModel.fromMap(Map<String, dynamic> map) {
    return AppointmentCountsModel(
      availableCount: map['available_count'] ?? 0,
      bookedCount: map['booked_count'] ?? 0,
    );
  }
}
