import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/model/message_model.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class MessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  bool hasMore = true;
  String? video;
  String? image;
  final ImagePicker _picker = ImagePicker();

  List<ChatMessageModel> messages = [];

  String chatId = "";
  String name = "";

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;
  String? _listeningChatId;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  static MessageController get instance => Get.put(MessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  Future<void> getMessageRepo({bool refresh = false}) async {
    if (chatId.isEmpty) return;

    if (refresh) {
      page = 1;
      hasMore = true;
      messages.clear();
    }

    if (!hasMore && !refresh) return;

    if (page == 1) {
      isLoading = true;
    } else {
      isMoreLoading = true;
    }
    update();

    try {
      final response =
          await ApiService.get("${ApiEndPoint.getMessage}$chatId?page=$page&limit=20");

      if (response.statusCode == 200) {
        final rawMessages = _extractMessageList(response.data);

        if (rawMessages.isEmpty) {
          hasMore = false;
        } else {
          final parsed = rawMessages
              .whereType<Map<String, dynamic>>()
              .map(MessageModel.fromJson)
              .map(_mapMessageToChatModel)
              .toList();

          messages.addAll(parsed);
          messages.sort((a, b) => b.time.compareTo(a.time));
          page += 1;
        }

        status = Status.completed;
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
        status = Status.error;
      }
    } catch (e) {
      Utils.errorSnackBar('Message', 'Failed to load messages');
      status = Status.error;
    } finally {
      isLoading = false;
      isMoreLoading = false;
      update();
    }
  }

  Future<void> addNewMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || chatId.isEmpty) return;

    isMessage = true;
    update();

    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: text,
        image: LocalStorage.myImage,
        isMe: true,
      ),
    );
    update();

    messageController.clear();

    try {
      final payload = jsonEncode({"text": text});

      final response = await ApiService.multipart(
        "${ApiEndPoint.sendMessage}$chatId",
        body: {"data": payload},
        imagePath: (video != null && video!.isNotEmpty) ? video : null,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
      }
      await getMessageRepo(refresh: true);
    } catch (e) {
      Utils.errorSnackBar('Message', 'Failed to send message');
    } finally {
      isMessage = false;
      video = null;
      update();
    }
  }

  void listenMessage() {
    if (_listeningChatId != null) {
      print("MessageController: Already listening for userId: $_listeningChatId");
      return;
    }
    final userId = LocalStorage.userId;
    if (userId.isEmpty) {
      print("MessageController: No userId found, cannot listen for socket events");
      return;
    }
    _listeningChatId = userId;

    final eventKey = 'chatListUpdate::$userId';
    print("MessageController: Setting up socket listener for event: $eventKey");

    SocketServices.on(eventKey, (data) async {
      print("MessageController: Socket event received: $eventKey");
      print("MessageController: Socket data: $data");
      
      if (chatId.isEmpty) return;
      print("MessageController: Processing messages for chatId: $chatId");

      // Check if this socket event is for the current chat
      String eventChatId = '';
      if (data is Map<String, dynamic>) {
        eventChatId = data['chatId']?.toString() ?? '';
      }
      
      if (eventChatId.isNotEmpty && eventChatId != chatId) {
        print("MessageController: Socket event for different chat ($eventChatId), ignoring");
        return;
      }

      print("MessageController: Socket data received: $data");
      
      // Direct extraction for different data structures
      List extracted = [];
      
      if (data is Map<String, dynamic>) {
        // Try to find message in different possible structures
        if (data['lastMessage'] != null) {
          extracted = [data['lastMessage']];
          print("MessageController: Found lastMessage structure");
        } else if (data['text'] != null) {
          extracted = [data];
          print("MessageController: Found direct message structure");
        } else if (data['data'] != null) {
          final dataField = data['data'];
          if (dataField is List) {
            extracted = List.from(dataField);
            print("MessageController: Found data list structure");
          } else if (dataField is Map) {
            extracted = [dataField];
            print("MessageController: Found data object structure");
          }
        }
      }
      
      // Fallback extraction
      if (extracted.isEmpty) {
        extracted = _extractMessageList(data);
        print("MessageController: Using fallback extraction: ${extracted.length} messages");
      }
      
      print("MessageController: Total messages to process: ${extracted.length}");
      
      if (extracted.isEmpty) {
        print("MessageController: No messages found, ignoring");
        return;
      }

      final parsed = extracted
          .whereType<Map<String, dynamic>>()
          .map(MessageModel.fromJson)
          .map(_mapMessageToChatModel)
          .toList()
        ..sort((a, b) => b.time.compareTo(a.time));

      print("MessageController: Parsed ${parsed.length} messages, updating UI");

      // WhatsApp-style update - add new messages without clearing
      for (final newMsg in parsed) {
        // Check if message already exists (by text, time, and sender)
        final exists = messages.any((msg) => 
          msg.text == newMsg.text && 
          msg.time.isAtSameMomentAs(newMsg.time) &&
          msg.isMe == newMsg.isMe
        );
        
        if (!exists) {
          // Insert new message at top (most recent)
          messages.insert(0, newMsg);
        }
      }

      status = Status.completed;
      update();
      print("MessageController: Message screen UI updated");
    });
    
    print("MessageController: Socket listener setup complete for userId: $userId");
  }

  void isEmoji(int index) {
    currentIndex = index;
    isInputField = isInputField;
    update();
  }

  List _extractMessageList(dynamic data) {
    if (data is List) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      final messagesField = data['messages'];
      if (messagesField != null) {
        final nested = _extractMessageList(messagesField);
        if (nested.isNotEmpty) return nested;
      }

      final dataField = data['data'];
      if (dataField != null) {
        final nested = _extractMessageList(dataField);
        if (nested.isNotEmpty) return nested;
      }

      final attributesField = data['attributes'];
      if (attributesField != null) {
        final nested = _extractMessageList(attributesField);
        if (nested.isNotEmpty) return nested;
      }
    }

    return [];
  }

  ChatMessageModel _mapMessageToChatModel(MessageModel message) {
    String? mediaPath;
    String? mediaType;
    
    print("MessageController: Mapping message - Type: ${message.type}");
    print("MessageController: Images array: ${message.images}");
    print("MessageController: Message text: ${message.message}");
    
    // Handle images array from API response
    if (message.images.isNotEmpty) {
      mediaPath = message.images.first; // Take first image for now
      mediaType = 'image';
      print("MessageController: Found image path: $mediaPath");
    }
    
    // Use mediaType instead of trying to modify message.type
    if (mediaPath != null && message.type == 'text') {
      print("MessageController: Using 'image' mediaType because image path exists despite server saying 'text'");
    }
    
    return ChatMessageModel(
      time: message.createdAt.toLocal(),
      text: message.message,
      image: message.sender.image,
      isNotice: message.type == "notice",
      isMe: LocalStorage.userId == message.sender.id,
      mediaPath: mediaPath,
      mediaType: mediaType,
    );
  }

  // Image and Video selection methods
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        image = pickedFile.path;
        video = null;
        update();
        print("Image picked from camera: ${pickedFile.path}");
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to pick image from camera: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        image = pickedFile.path;
        video = null;
        update();
        print("Image picked from gallery: ${pickedFile.path}");
      }
      
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to pick image from gallery: $e');
    }
  }

  Future<void> pickVideoFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 5),
      );
      if (pickedFile != null) {
        video = pickedFile.path;
        image = null;
        update();
        print("Video picked from camera: ${pickedFile.path}");
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to pick video from camera: $e');
    }
  }

  Future<void> pickVideoFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      if (pickedFile != null) {
        video = pickedFile.path;
        image = null;
        update();
        print("Video picked from gallery: ${pickedFile.path}");
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to pick video from gallery: $e');
    }
  }

  void showMediaPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Media',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    
                    // Image options
                    Text(
                      'Image',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: _mediaOptionTile(
                            icon: Icons.camera_alt,
                            title: 'Camera',
                            onTap: () {
                              Get.back();
                              pickImageFromCamera();
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _mediaOptionTile(
                            icon: Icons.photo_library,
                            title: 'Gallery',
                            onTap: () {
                              Get.back();
                              pickImageFromGallery();
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Video options
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: _mediaOptionTile(
                            icon: Icons.videocam,
                            title: 'Camera',
                            onTap: () {
                              Get.back();
                              pickVideoFromCamera();
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _mediaOptionTile(
                            icon: Icons.video_library,
                            title: 'Gallery',
                            onTap: () {
                              Get.back();
                              pickVideoFromGallery();
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mediaOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: GetPlatform.isIOS ? Colors.blue : Colors.green,
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearMedia() {
    image = null;
    video = null;
    update();
  }

  Future<void> sendMediaMessage() async {
    final text = messageController.text.trim();
    final mediaPath = image ?? video;
    
    if (mediaPath == null || chatId.isEmpty) {
      Utils.errorSnackBar('Error', 'Please select media first');
      return;
    }

    isMessage = true;
    update();

    // Add message to UI immediately
    final mediaType = image != null ? 'image' : 'video';
    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: text.isEmpty ? "Sent a $mediaType" : text,
        image: LocalStorage.myImage,
        isMe: true,
        mediaPath: mediaPath,
        mediaType: mediaType,
      ),
    );
    update();

    messageController.clear();

    try {
      final payload = {
        "text": text,
        "type": mediaType,
      };
      
      print("MessageController: Sending media message...");
      print("MessageController: ChatId: $chatId");
      print("MessageController: MediaType: $mediaType");
      print("MessageController: MediaPath: $mediaPath");
      print("MessageController: Payload: $payload");
      print("MessageController: Full URL: ${ApiEndPoint.sendMessage}$chatId");

      // Try sending as an array of images
      if (mediaType == 'image') {
        final response = await ApiService.multipart(
          "${ApiEndPoint.sendMessage}$chatId",
          body: payload,
          imagePath: mediaPath,
          imageName: 'images',
        );
        
        print("MessageController: Response status: ${response.statusCode}");
        print("MessageController: Response data: ${response.data}");
        print("MessageController: Response message: ${response.message}");

        if (response.statusCode != 200 && response.statusCode != 201) {
          print("MessageController: Error response: ${response.message}");
          Utils.errorSnackBar(response.statusCode.toString(), response.message);
        } else {
          print("MessageController: Message sent successfully!");
        }
      } else {
        // For videos, keep the current approach
        final response = await ApiService.multipart(
          "${ApiEndPoint.sendMessage}$chatId",
          body: payload,
          imagePath: mediaPath,
          imageName: 'video',
        );
        
        print("MessageController: Response status: ${response.statusCode}");
        print("MessageController: Response data: ${response.data}");
        print("MessageController: Response message: ${response.message}");

        if (response.statusCode != 200 && response.statusCode != 201) {
          print("MessageController: Error response: ${response.message}");
          Utils.errorSnackBar(response.statusCode.toString(), response.message);
        } else {
          print("MessageController: Message sent successfully!");
        }
      }
      
      await getMessageRepo(refresh: true);
    } catch (e) {
      print("MessageController: Exception caught: $e");
      Utils.errorSnackBar('Message', 'Failed to send media message: $e');
    } finally {
      isMessage = false;
      clearMedia();
      update();
    }
  }
}