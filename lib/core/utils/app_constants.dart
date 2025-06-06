class AppConstants {
  static const String projectURL = 'https://sesjzerlawpywdufplrw.supabase.co';
  static const String aPIKeyAnon =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlc2p6ZXJsYXdweXdkdWZwbHJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExMDgyNTgsImV4cCI6MjA1NjY4NDI1OH0.doP5RPAicAhB8lCflfWqupp4MQdYeg_QErCX3RDE_rQ';
  static const String doctor = 'Doctor';
  static const String patient = 'Patient';
  static const String male = 'Male';
  static const String female = 'Female';

  // -- usersTable --
  static const String usersTable = 'Users';
  static const String userId = 'id';
  static const String userCreatedAt = 'created_at';
  static const String userFirstName = 'first_name';
  static const String userLastName = 'last_name';
  static const String userGender = 'gender';
  static const String userUserType = 'user_type';
  static const String userBirthDate = 'birth_date';
  static const String userEmail = 'email';
  static const String userImageUrl = 'image_url';

  // -- doctorsTable --
  static const String doctorsTable = 'Doctors';
  static const String doctorId = 'id';
  static const String doctorCreatedAt = 'created_at';
  static const String doctorUserId = 'user_id';
  static const String doctorSpecialization = 'specialization';
  static const String doctorExperience = 'experience';
  static const String doctorClinicAddress = 'clinic_address';
  static const String doctorConsultationFee = 'consultation_fee';

  // -- specializationsTable --
  static const String specializationsTable = 'Specializations';
  static const String specializationId = 'id';
  static const String specializationCreatedAt = 'created_at';
  static const String specializationSpecialization = 'specialization';
  static const String specializationImage = 'image';

  // -- doctorAvailableAppointmentsTable --
  static const String doctorAvailableAppointmentsTable =
      'Doctor_Available_Appointments';
  static const String doctorAvailableAppointmentId = 'id';
  static const String doctorAvailableAppointmentCreatedAt = 'created_at';
  static const String doctorAvailableAppointmentDoctorId = 'doctor_id';
  static const String doctorAvailableAppointmentDate = 'available_date';
  static const String doctorAvailableAppointmentTime = 'available_time';
  static const String doctorAvailableAppointmentIsBooked = 'is_booked';

  // -- appointmentsTable --
  static const String appointmentsTable = 'Appointments';
  static const String appointmentId = 'id';
  static const String appointmentCreatedAt = 'created_at';
  static const String appointmentPatientId = 'patient_id';
  static const String appointmentDoctorId = 'doctor_id';
  static const String appointmentSlotId = 'slot_id';
  static const String appointmentStatus = 'status';
}
