import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/helpers/image_helper.dart';


class ChatBubbleMessage extends StatelessWidget {
  final DateTime time;
  final String text;
  final String image;
  final bool isMe;
  final int index;
  final int messageIndex;
  final String? mediaPath;
  final String? mediaType;

  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.text,
    required this.image,
    required this.isMe,
    required this.onTap,
    this.index = 0,
    this.messageIndex = 1,
    this.mediaPath,
    this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
                color: isMe?Color(0xFFE7EAED):AppColors.primaryColor                    ),
            padding:  EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Media content
                if (mediaPath != null && mediaType != null)
                  _buildMediaContent(),
                
                // Text content (show if there's text or no media)
                if (text.isNotEmpty || mediaPath == null)
                  Padding(
                    padding: EdgeInsets.only(top: mediaPath != null ? 8.h : 0),
                    child: CommonText(
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      text: text,
                      fontSize: 18,
                      color:isMe? AppColors.titleColor:AppColors.white,
                    ),
                  ),
                
                SizedBox(height: 4.h),
                
                // Time
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      color:isMe?Color(0xFF111827):AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      text: _formatTime(time),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaContent() {
    if (mediaType == 'image' && mediaPath != null) {
      final imageUrl = ImageHelper.buildImageUrl(mediaPath);
      print("ChatBubbleMessage: mediaPath: $mediaPath");
      print("ChatBubbleMessage: imageUrl: $imageUrl");
      print("ChatBubbleMessage: imageUrl starts with http: ${imageUrl.startsWith('http')}");
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: imageUrl.startsWith('http')
            ? Image.network(
                imageUrl,
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("ChatBubbleMessage: Image.network error: $error");
                  return Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.broken_image,
                      size: 50.sp,
                      color: Colors.grey[600],
                    ),
                  );
                },
              )
            : File(mediaPath!).existsSync()
                ? Image.file(
                    File(mediaPath!),
                    width: 200.w,
                    height: 200.w,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 50.sp,
                      color: Colors.grey[600],
                    ),
                  ),
      );
    } else if (mediaType == 'video' && mediaPath != null) {
      final videoUrl = ImageHelper.buildImageUrl(mediaPath);
      return Container(
        width: 200.w,
        height: 150.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (videoUrl.startsWith('http'))
              Container(
                width: 200.w,
                height: 150.w,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.play_circle_filled,
                  size: 60.sp,
                  color: Colors.white,
                ),
              )
            else if (File(mediaPath!).existsSync())
              Icon(
                Icons.play_circle_filled,
                size: 60.sp,
                color: Colors.white,
              )
            else
              Icon(
                Icons.videocam_off,
                size: 50.sp,
                color: Colors.grey[600],
              ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: CommonText(
                  text: 'Video',
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
