class ValidationConstants {
  static const String phonePattern = r'^[0-9]{10,13}$';
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  static const int phoneMinLength = 10;
  static const int phoneMaxLength = 13;

  static const int emailMinLength = 5;
}
