class AppConstants {
  static const String projectURL = 'https://sesjzerlawpywdufplrw.supabase.co';
  static const String aPIKeyAnon =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlc2p6ZXJsYXdweXdkdWZwbHJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExMDgyNTgsImV4cCI6MjA1NjY4NDI1OH0.doP5RPAicAhB8lCflfWqupp4MQdYeg_QErCX3RDE_rQ';

  // -- ثابت القيم --
  static const String doctor = 'Doctor';
  static const String patient = 'Patient';
  static const String male = 'Male';
  static const String female = 'Female';

  // -- Users Table --
  static const String usersTable = 'Users';
  static const String userId = 'id';
  static const String userCreatedAt = 'created_at';
  static const String userFirstName = 'first_name';
  static const String userLastName = 'last_name';
  static const String userGender = 'gender';
  static const String userUserType = 'user_type';
  static const String userBirthDate = 'birth_date';
  static const String userEmail = 'email';

  // -- Doctors Table --
  static const String doctorsTable = 'Doctors';
  static const String doctorId = 'id';
  static const String doctorCreatedAt = 'created_at';
  static const String doctorUserId = 'user_id';
  static const String doctorSpecializationId = 'specialization';
  static const String doctorExperience = 'experience';
  static const String doctorClinicAddress = 'clinic_address';
  static const String doctorConsultationFee = 'consultation_fee';
  static const String doctorImageUrl = 'image_url';
  static const String doctorInfo = 'info';
  static const String doctorPhoneNumber = 'phone_number';

  // -- Specializations Table --
  static const String specializationsTable = 'Specializations';
  static const String specializationId = 'id';
  static const String specializationCreatedAt = 'created_at';
  static const String specializationName = 'specialization';
  static const String specializationImage = 'image';

  // -- Appointments Table --
  static const String appointmentsTable = 'Appointments';
  static const String appointmentId = 'id';
  static const String appointmentCreatedAt = 'created_at';
  static const String appointmentPatientId = 'patient_id';
  static const String appointmentDoctorId = 'doctor_id';
  static const String appointmentAvailableDate = 'available_date';
  static const String appointmentDuration = 'duration';
  static const String appointmentIsBooked = 'is_booked';

  // -- Doctors_Ratings Table --
  static const String doctorRatingsTable = 'Doctors_Ratings';
  static const String doctorRatingId = 'id';
  static const String doctorRatingCreatedAt = 'created_at';
  static const String doctorRatingDoctorId = 'doctor_id';
  static const String doctorRatingPatientId = 'patient_id';
  static const String doctorRatingValue = 'rating';
  static const String doctorRatingComment = 'comment';

  // -- View or Logic Constants (غير موجود في الـ schema لكن يمكن الاحتفاظ بها) --
  static const String doctorAverageRatings = 'Doctor_Average_Ratings';
}
