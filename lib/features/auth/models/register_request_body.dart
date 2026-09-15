class RegisterRequestBody {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  RegisterRequestBody({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
