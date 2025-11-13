import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/helpers/other_helper.dart';
import '../../data/model/profile_model.dart';
import '../../data/repository/profile_repository.dart';

class ProfileController extends GetxController {
  // Profile data
  ProfileData? profileData;
  bool isLoadingProfile = false;
  
  /// Language List here
  List languages = ["English", "French", "Arabic"];

  /// form key here
  final formKey = GlobalKey<FormState>();

  /// select Language here
  String selectedLanguage = "English";

  /// edit button loading here
  bool isLoading = false;

  /// all controller here
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  /// select image function here
  String? image;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  /// Fetch user profile data
  Future<void> fetchProfile() async {
    try {
      isLoadingProfile = true;
      update();

      final response = await ProfileRepository.getProfile();
      
      if (response != null && response.data != null) {
        profileData = response.data;
        
        // Update text controllers with fetched data
        nameController.text = profileData?.name ?? '';
        emailController.text = profileData?.email ?? '';
        
        Utils.successSnackBar('Success', 'Profile loaded successfully');
      } else {
        Utils.errorSnackBar('Error', 'Failed to load profile data');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoadingProfile = false;
      update();
    }
  }

  /// Refresh profile data
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  /// Get profile image URL with fallback
  String getProfileImageUrl() {
    if (profileData?.hasProfileImage == true) {
      // Add cache busting parameter to force refresh
      final imageUrl = profileData!.profileImage;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      return imageUrl.contains('?') 
          ? '$imageUrl&t=$timestamp' 
          : '$imageUrl?t=$timestamp';
    }
    return ''; // Will use default image from CommonImage
  }

  /// Get user display name
  String getUserName() {
    return profileData?.name ?? 'User Name';
  }

  /// Get user role
  String getUserRole() {
    return profileData?.formattedRole ?? 'Member';
  }

  /// select image function here
  getProfileImage() async {
    try {
      final selectedImage = await OtherHelper.openGallery();
      
      if (selectedImage != null && selectedImage.isNotEmpty) {
        image = selectedImage;
        print("Image selected: $image");
        
        // Optional: Check if file exists for debugging
        final imageFile = File(selectedImage);
        final exists = await imageFile.exists();
        print("File exists at selection time: $exists");
        
        if (exists) {
          final size = await imageFile.length();
          print("File size: $size bytes");
        }
      } else {
        image = null;
        print("No image selected");
      }
      
      update();
    } catch (e) {
      print("Error selecting image: $e");
      // Don't clear the image on error, just log it
      update();
    }
  }

  /// Update profile image
  Future<void> updateProfileImage() async {
    if (image == null || image!.isEmpty) {
      Utils.errorSnackBar('Error', 'Please select an image first');
      return;
    }

    try {
      isLoading = true;
      update();

      final response = await ProfileRepository.updateProfileImage(image!);
      
      if (response != null && response.data != null) {
        // Update local profile data
        profileData = response.data;
        
        // Clear selected image since it's now uploaded
        image = null;
        
        Utils.successSnackBar('Success', 'Profile image updated successfully');
        
        // Refresh profile data
        await fetchProfile();
      } else {
        Utils.errorSnackBar('Error', 'Failed to update profile image');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  /// select language  function here
  selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) {
      Utils.errorSnackBar('Validation Error', 'Please fill all required fields');
      return;
    }

    try {
      isLoading = true;
      update();

      // Prepare body data with name, phone, and address
      Map<String, String> bodyData = <String, String>{};
      bodyData["name"] = nameController.text.trim();
      bodyData["phone"] = numberController.text.trim();
      bodyData["address"] = addressController.text.trim();

      // Debug: Print the data being sent
      print("Updating profile with data: $bodyData");
      print("Image selected: ${image != null ? 'Yes' : 'No'}");

      var response;

      // If image is selected, use multipart request
      if (image != null && image!.isNotEmpty) {
        print("Image path: $image");
        
        // Check if file exists (but don't fail if it doesn't)
        final imageFile = File(image!);
        final fileExists = await imageFile.exists();
        print("File exists: $fileExists");
        
        if (fileExists) {
          final fileSize = await imageFile.length();
          print("File size: $fileSize bytes");
        }
        
        print("Attempting multipart request with image");
        print("Image file name: ${imageFile.path.split('/').last}");
        
        try {
          // Create a unique filename with timestamp to force server to process new image
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final originalFileName = imageFile.path.split('/').last;
          final extension = originalFileName.split('.').last;
          final uniqueFileName = "profile_${timestamp}.$extension";
          
          print("Sending image with unique filename: $uniqueFileName");
          print("Original file: $originalFileName");
          
          // Copy the file to a new location with unique name to ensure it's treated as new
          final tempDir = Directory.systemTemp;
          final tempFile = File('${tempDir.path}/$uniqueFileName');
          await imageFile.copy(tempFile.path);
          
          print("Copied to temp file: ${tempFile.path}");
          print("Temp file exists: ${await tempFile.exists()}");
          print("Temp file size: ${await tempFile.length()} bytes");
          
          response = await ApiService.multipart(
            ApiEndPoint.getProfile,
            method: 'PATCH',
            body: bodyData,
            imagePath: tempFile.path,
            imageName: "profileImage",
          );
          
          // Clean up temp file
          try {
            await tempFile.delete();
            print("Temp file deleted");
          } catch (e) {
            print("Failed to delete temp file: $e");
          }
          
          print("Multipart request completed successfully");
          print("Response contains: ${response.data}");
          
          // Check if the response contains a new image URL
          if (response.data != null && response.data['data'] != null) {
            final newImageUrl = response.data['data']['profileImage'];
            print("New profile image URL from server: $newImageUrl");
          }
          
        } catch (imageError) {
          print("Multipart request failed: $imageError");
          print("Falling back to regular PATCH request");
          response = await ApiService.patch(
            ApiEndPoint.getProfile,
            body: bodyData,
          );
        }
      } else {
        print("Using regular PATCH request");
        response = await ApiService.patch(
          ApiEndPoint.getProfile,
          body: bodyData,
        );
      }

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        await _handleUpdateSuccess(response);
      } else {
        Utils.errorSnackBar('Update Failed', 'Server returned: ${response.statusCode} - ${response.message ?? 'Unknown error'}');
      }
    } catch (e) {
      print("Profile update error: $e");
      Utils.errorSnackBar('Error', 'Something went wrong: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Handle successful profile update
  Future<void> _handleUpdateSuccess(response) async {
    try {
      // Clear selected image since it's now uploaded
      image = null;
      
      // Add a small delay to ensure server processing is complete
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Force refresh profile data from server
      print("Refreshing profile data after update...");
      await fetchProfile();
      
      Utils.successSnackBar('Success', 'Profile updated successfully');
      
      // Navigate back to profile screen
      Get.back();
    } catch (e) {
      Utils.errorSnackBar('Error', 'Profile updated but failed to refresh data: $e');
    }
  }

  /// Logout user with options
  Future<void> logoutUser({bool clearRememberedCredentials = false}) async {
    try {
      // Show confirmation dialog
      bool? shouldLogout = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        // Perform logout
        await LocalStorage.logout(clearRememberedCredentials: clearRememberedCredentials);
        
        Utils.successSnackBar('Success', 'You have been logged out successfully.');
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to logout. Please try again.');
    }
  }

  /// Quick logout without confirmation (for settings)
  Future<void> quickLogout() async {
    try {
      await LocalStorage.logout(clearRememberedCredentials: false);
      Utils.successSnackBar('Success', 'Logged out successfully.');
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to logout. Please try again.');
    }
  }
}
