import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/log/app_log.dart';
import '../model/profile_model.dart';

class ProfileRepository {
  /// Get user profile data
  static Future<ProfileResponse?> getProfile() async {
    try {
      appLog("Fetching user profile...", source: "ProfileRepository");
      
      final response = await ApiService.get(ApiEndPoint.getProfile);
      
      if (response.statusCode == 200) {
        appLog("Profile fetched successfully", source: "ProfileRepository");
        return ProfileResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        appLog("Failed to fetch profile: ${response.statusCode}", source: "ProfileRepository");
        return null;
      }
    } catch (e) {
      appLog("Error fetching profile: $e", source: "ProfileRepository");
      return null;
    }
  }

  /// Update user profile with complete data structure
  static Future<ProfileResponse?> updateProfile({
    required String name,
    Map<String, String>? shippingAddress,
  }) async {
    try {
      appLog("Updating user profile...", source: "ProfileRepository");
      
      Map<String, dynamic> body = {
        'name': name,
      };

      if (shippingAddress != null) {
        body['shippingAddress'] = shippingAddress;
      }

      final response = await ApiService.patch(
        ApiEndPoint.getProfile,
        body: body,
      );
      
      if (response.statusCode == 200) {
        appLog("Profile updated successfully", source: "ProfileRepository");
        return ProfileResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        appLog("Failed to update profile: ${response.statusCode}", source: "ProfileRepository");
        return null;
      }
    } catch (e) {
      appLog("Error updating profile: $e", source: "ProfileRepository");
      return null;
    }
  }

  /// Update profile image only
  static Future<ProfileResponse?> updateProfileImage(String imagePath) async {
    try {
      appLog("Updating profile image...", source: "ProfileRepository");
      
      // For multipart file upload
      final response = await ApiService.multipart(
        ApiEndPoint.getProfile,
        method: 'PATCH',
        imageName: 'profileImage',
        imagePath: imagePath,
      );
      
      if (response.statusCode == 200) {
        appLog("Profile image updated successfully", source: "ProfileRepository");
        return ProfileResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        appLog("Failed to update profile image: ${response.statusCode}", source: "ProfileRepository");
        return null;
      }
    } catch (e) {
      appLog("Error updating profile image: $e", source: "ProfileRepository");
      return null;
    }
  }
}
