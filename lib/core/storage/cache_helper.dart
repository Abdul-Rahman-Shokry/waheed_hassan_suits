import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/models/user_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;
  static late FlutterSecureStorage _secureStorage;

  static String? _token;
  static String? _refreshToken;

  static const String _tokenKey = "token";
  static const String _refreshTokenKey = "refreshToken";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        resetOnError: true,
      ),
    );

    _token = await _secureStorage.read(key: _tokenKey);
    _refreshToken = await _secureStorage.read(key: _refreshTokenKey);
  }

  static void setIsNotFirstTime() {
    _prefs.setBool("isFirstTime", false);
  }

  static bool get isFirstTime {
    return _prefs.getBool("isFirstTime") ?? true;
  }

  static bool get isLoggedIn {
    return (_token ?? "").isNotEmpty;
  }

  static String? get token {
    return _token;
  }

  static String? get refreshToken {
    return _refreshToken;
  }

  static String get fullName {
    return _prefs.getString("fullName") ?? "fullName";
  }

  static String get email {
    return _prefs.getString("email") ?? "";
  }

  static Future<void> saveUserData({UserModel? model}) async {
    if (model == null) return;

    _token = model.token;
    _refreshToken = model.refreshToken;

    await _secureStorage.write(key: _tokenKey, value: model.token);
    await _secureStorage.write(key: _refreshTokenKey, value: model.refreshToken);

    await _prefs.setString("email", model.email);
    await _prefs.setString("fullName", model.fullName);
    await _prefs.setString("message", model.message);
    await _prefs.setBool("isAuthenticated", model.isAuthenticated);
    await _prefs.setBool("requiresEmailVerification", model.requiresEmailVerification);
    await _prefs.setString("userId", model.id);
  }

  static Future<void> clearSharedPrefs() async {
    _token = null;
    _refreshToken = null;

    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);

    await _prefs.remove("email");
    await _prefs.remove("fullName");
    await _prefs.remove("message");
    await _prefs.remove("isAuthenticated");
    await _prefs.remove("requiresEmailVerification");
    await _prefs.remove("userId");
  }
}