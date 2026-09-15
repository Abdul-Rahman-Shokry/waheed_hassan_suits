class RegisterModel {
  late final String email;
  late final String fullName;
  late final String token;
  late final String tokenExpiry;
  late final String refreshToken;
  late final String refreshTokenExpiry;
  late final String message;
  late final bool isAuthenticated;
  late final bool requiresEmailVerification;
  late final String id;

  RegisterModel.fromJson(Map<String, dynamic> json){
    email = json['email'] ?? "";
    fullName = json['fullName'] ?? "";
    token = json['token'] ?? "";
    tokenExpiry = json['tokenExpiry'] ?? "";
    refreshToken = json['refreshToken'] ?? "";
    refreshTokenExpiry = json['refreshTokenExpiry'] ?? "";
    message = json['message'] ?? "";
    isAuthenticated = json['isAuthenticated'] ?? false;
    requiresEmailVerification = json['requiresEmailVerification'] ?? false;
    id = json['id'] ?? "";
  }
}