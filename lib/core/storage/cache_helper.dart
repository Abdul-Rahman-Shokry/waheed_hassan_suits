import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/models/user_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setIsNotFirstTime() {
    _prefs.setBool("isFirstTime", false);
  }

  static bool get isFirstTime {
    return _prefs.getBool("isFirstTime") ?? true;
  }

  static bool get isLoggedIn {
    return (_prefs.getString("token") ?? "").isNotEmpty;
  }

  static String? get token {
    return _prefs.getString("token");
  }

  static String get fullName {
    return _prefs.getString("fullName") ?? "fullName";
  }

  // static String get profilePhotoUrl {
  //   return _prefs.getString("profilePhotoUrl") ??
  //       "https://img.icons8.com/color/1200/person-male.jpg";
  // }

  static Future<void> saveUserData({UserModel? model}) async {
    if (model == null) return;

    _prefs.setString("email", model.email);
    _prefs.setString("fullName", model.fullName);
    _prefs.setString("token", model.token);
    _prefs.setString("refreshToken", model.refreshToken);
    _prefs.setString("message", model.message);
    _prefs.setBool("isAuthenticated", model.isAuthenticated);
    _prefs.setBool("requiresEmailVerification", model.requiresEmailVerification,);
    _prefs.setString("userId", model.id);
  }

  static Future<void> clearSharedPrefs() async {
    await _prefs.remove("email");
    await _prefs.remove("fullName");
    await _prefs.remove("token");
    await _prefs.remove("refreshToken");
    await _prefs.remove("message");
    await _prefs.remove("isAuthenticated");
    await _prefs.remove("requiresEmailVerification");
    await _prefs.remove("userId");
    // don't remove `isFirstTime`
  }

  static String get email {
    return _prefs.getString("email") ?? "";
  }
}
