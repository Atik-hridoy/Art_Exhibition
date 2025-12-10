import '../../config/api/api_end_point.dart';

class ImageHelper {
  /// Safely constructs image URL by combining base URL with image path
  static String buildImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    
    // If already a complete URL, return as is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // Remove leading slash if present to avoid double slashes
    String cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    
    // Fix for chat images - they need /uploads/images/ prefix
    if (cleanPath.startsWith('images/')) {
      return '${ApiEndPoint.imageUrl}/uploads/$cleanPath';
    }
    
    // Combine base URL with clean path for other images
    return '${ApiEndPoint.imageUrl}/$cleanPath';
  }
  
  /// Validates if the given URL is a valid image URL
  static bool isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    
    try {
      final uri = Uri.parse(url);
      return uri.hasAbsolutePath && 
             (uri.scheme == 'http' || uri.scheme == 'https') &&
             url != ApiEndPoint.imageUrl;
    } catch (e) {
      return false;
    }
  }
}
