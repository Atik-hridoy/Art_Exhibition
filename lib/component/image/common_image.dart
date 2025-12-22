import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasaned_project/utils/constants/app_loader.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/log/error_log.dart';

class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;

  final BoxFit fill;

  const CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.contain,
    this.defaultImage = AppImages.homeInactive,
    super.key,
  });

  checkImageType() {}

  @override
  Widget build(BuildContext context) {
    if (imageSrc.contains("assets/icons") && imageSrc.endsWith(".svg")) {
      return _buildSvgImage();
    } else if (imageSrc.contains("assets/icons") && (imageSrc.endsWith(".png") || imageSrc.endsWith(".jpg") || imageSrc.endsWith(".jpeg"))) {
      return _buildPngImage();
    } else if (imageSrc.contains("assets/images")) {
      return _buildPngImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildErrorWidget() {
    return Image.asset(defaultImage);
  }

  Widget _buildNetworkImage() {
    // Build full URL if it's a relative path
    String fullImageUrl = imageSrc;
    if (imageSrc.isNotEmpty && 
        !imageSrc.startsWith('http') && 
        !imageSrc.startsWith('assets') &&
        imageSrc.startsWith('/')) {
      fullImageUrl = '${ApiEndPoint.imageUrl}$imageSrc';
    }
    
    // Validate image URL before loading
    if (fullImageUrl.isEmpty || 
        fullImageUrl == ApiEndPoint.imageUrl || 
        Uri.tryParse(fullImageUrl)?.hasAbsolutePath != true) {
      return _buildErrorWidget();
    }
    
    return CachedNetworkImage(
      height: size ?? height,
      width: size ?? width,
      imageUrl: fullImageUrl,
      fit: fill,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider, fit: fill),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => AppLoader(
        loaderChild: SizedBox(height: size ?? height, width: size ?? width),
        isLoading: true,
        child: const SizedBox.shrink(),
      ),
      errorWidget: (context, url, error) {
        // Only log critical errors, not 404s for missing images
        if (error is Exception && !error.toString().contains('404')) {
          errorLog(error, source: "Common Image");
        }
        return _buildErrorWidget();
      },
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      imageSrc,
      color: imageColor,
      height: size ?? height,
      width: size ?? width,
      fit: fill,
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imageSrc,
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {

        if (error is Exception && !error.toString().contains('Unable to load asset')) {
          errorLog(error, source: "Common Image");
        }
        return _buildErrorWidget();
      },
      ),
    );
  }
}
