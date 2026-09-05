class UserModel {
  late final String email;
  late final String fullName;
  late final String token;
  late final String refreshToken;
  late final String message;
  late final bool isAuthenticated;
  late final bool requiresEmailVerification;
  late final String id;

  UserModel.fromJson(Map<String, dynamic> json){
    email = json['email'] ?? "";
    fullName = json['fullName'] ?? "";
    token = json['token'] ?? "";
    refreshToken = json['refreshToken'] ?? "";
    message = json['message'] ?? "";
    isAuthenticated = json['isAuthenticated'] ?? false;
    requiresEmailVerification = json['requiresEmailVerification'] ?? false;
    id = json['id'] ?? "";
  }
}