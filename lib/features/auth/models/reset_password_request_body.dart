class ResetPasswordRequestBody {
  final String email;
  final String newPassword;
  final String confirmNewPassword;
  final String otpCode;

  ResetPasswordRequestBody({
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
      'otpCode': otpCode,
    };
  }
}