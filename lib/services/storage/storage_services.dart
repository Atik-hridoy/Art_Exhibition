import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/route/app_routes.dart';
import '../../utils/log/app_log.dart';
import 'storage_keys.dart';

class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRoll = "";
  
  // Remember Me functionality
  static bool rememberMe = false;
  static String rememberedEmail = "";
  static String rememberedPassword = "";
  static int lastLoginTime = 0;
  static bool autoLoginEnabled = false;

  // Create Local Storage Instance
  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    myRoll = localStorage.getString(LocalStorageKeys.myRoll) ?? "";
    
    // Remember Me data
    rememberMe = localStorage.getBool(LocalStorageKeys.rememberMe) ?? false;
    rememberedEmail = localStorage.getString(LocalStorageKeys.rememberedEmail) ?? "";
    rememberedPassword = localStorage.getString(LocalStorageKeys.rememberedPassword) ?? "";
    lastLoginTime = localStorage.getInt(LocalStorageKeys.lastLoginTime) ?? 0;
    autoLoginEnabled = localStorage.getBool(LocalStorageKeys.autoLoginEnabled) ?? false;

    appLog("User ID: $userId, Remember Me: $rememberMe, Auto Login: $autoLoginEnabled", source: "Local Storage");
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    Get.offAllNamed(AppRoutes.signIn);
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setString(LocalStorageKeys.myRoll, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
    
    // Reset remember me data (but keep remembered credentials if user wants)
    localStorage.setBool(LocalStorageKeys.autoLoginEnabled, false);
    localStorage.setInt(LocalStorageKeys.lastLoginTime, 0);
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final localStorage = await _getStorage();
    return localStorage.getString(key);
  }

  static Future<void> remove(String key) async {
    final localStorage = await _getStorage();
    await localStorage.remove(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }

  // ============ Remember Me Functionality ============

  /// Save user login credentials for remember me
  static Future<void> saveRememberMeCredentials({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await setBool(LocalStorageKeys.rememberMe, rememberMe);
    
    if (rememberMe) {
      await setString(LocalStorageKeys.rememberedEmail, email);
      await setString(LocalStorageKeys.rememberedPassword, password);
    } else {
      await clearRememberMeCredentials();
    }
  }

  /// Clear remembered credentials
  static Future<void> clearRememberMeCredentials() async {
    await setString(LocalStorageKeys.rememberedEmail, "");
    await setString(LocalStorageKeys.rememberedPassword, "");
    await setBool(LocalStorageKeys.rememberMe, false);
  }

  /// Save successful login session
  static Future<void> saveLoginSession({
    required String token,
    required String userId,
    required String userImage,
    required String userName,
    required String userEmail,
    required String userRole,
    bool enableAutoLogin = true,
  }) async {
    // Save user data
    LocalStorage.token = token;
    LocalStorage.userId = userId;
    LocalStorage.myImage = userImage;
    LocalStorage.myName = userName;
    LocalStorage.myEmail = userEmail;
    LocalStorage.myRoll = userRole;
    LocalStorage.isLogIn = true;
    LocalStorage.autoLoginEnabled = enableAutoLogin;
    LocalStorage.lastLoginTime = DateTime.now().millisecondsSinceEpoch;

    // Persist to storage
    await setBool(LocalStorageKeys.isLogIn, true);
    await setString(LocalStorageKeys.token, token);
    await setString(LocalStorageKeys.userId, userId);
    await setString(LocalStorageKeys.myImage, userImage);
    await setString(LocalStorageKeys.myName, userName);
    await setString(LocalStorageKeys.myEmail, userEmail);
    await setString(LocalStorageKeys.myRoll, userRole);
    await setBool(LocalStorageKeys.autoLoginEnabled, enableAutoLogin);
    await setInt(LocalStorageKeys.lastLoginTime, LocalStorage.lastLoginTime);

    appLog("Login session saved successfully", source: "LocalStorage");
  }

  /// Check if user should be auto-logged in
  static bool shouldAutoLogin() {
    if (!isLogIn || !autoLoginEnabled || token.isEmpty) {
      return false;
    }

    // Check if login is still valid (30 days)
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDifference = currentTime - lastLoginTime;
    final daysDifference = timeDifference / (1000 * 60 * 60 * 24);

    if (daysDifference > 30) {
      appLog("Auto-login expired after 30 days", source: "LocalStorage");
      return false;
    }

    return true;
  }

  /// Get remembered credentials
  static Map<String, String> getRememberedCredentials() {
    return {
      'email': rememberedEmail,
      'password': rememberedPassword,
    };
  }

  /// Logout user and clear session
  static Future<void> logout({bool clearRememberedCredentials = false}) async {
    // Clear session data
    token = "";
    refreshToken = "";
    isLogIn = false;
    userId = "";
    myImage = "";
    myName = "";
    myEmail = "";
    myRoll = "";
    autoLoginEnabled = false;
    lastLoginTime = 0;

    // Clear from storage
    await setString(LocalStorageKeys.token, "");
    await setString(LocalStorageKeys.refreshToken, "");
    await setBool(LocalStorageKeys.isLogIn, false);
    await setString(LocalStorageKeys.userId, "");
    await setString(LocalStorageKeys.myImage, "");
    await setString(LocalStorageKeys.myName, "");
    await setString(LocalStorageKeys.myEmail, "");
    await setString(LocalStorageKeys.myRoll, "");
    await setBool(LocalStorageKeys.autoLoginEnabled, false);
    await setInt(LocalStorageKeys.lastLoginTime, 0);

    // Optionally clear remembered credentials
    if (clearRememberedCredentials) {
      await clearRememberMeCredentials();
      rememberMe = false;
      rememberedEmail = "";
      rememberedPassword = "";
    }

    appLog("User logged out successfully", source: "LocalStorage");
    
    // Navigate to sign in
    Get.offAllNamed(AppRoutes.signIn);
  }
}
