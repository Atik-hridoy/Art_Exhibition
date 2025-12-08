import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/chat_list_model.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';
import '../../../../config/route/app_routes.dart';

class ChatController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  /// Chat more Data Loading Bar
  bool isMoreLoading = false;

  /// page no here
  int page = 1;

  /// Chat List here
  List<ChatModel> chats = [];

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Chat Controller Instance create here
  static ChatController get instance => Get.put(ChatController());

  /// Chat More data Loading function
  Future<void> moreChats() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isMoreLoading = true;
      update();
      await getChatRepo();
      isMoreLoading = false;
      update();
    }
  }

  /// Chat data Loading function
  Future<void> getChatRepo() async {
    try {
      if (page == 1) {
        status = Status.loading;
        chats.clear();
        update();
      }

      final response = await ApiService.get(ApiEndPoint.getAllCha);

      if (response.statusCode == 200) {
        final parsedChats = _parseChatList(response.data);
        chats
          ..clear()
          ..addAll(parsedChats);

        status = Status.completed;
        update();
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
        status = Status.error;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Chat', 'Failed to load chat list');
      status = Status.error;
      update();
    }
  }

  /// Chat data Update  Socket listener
  listenChat() async {
    SocketServices.on("update-chatlist::${LocalStorage.userId}", (data) {
      page = 1;
      chats.clear();

      for (var item in data) {
        chats.add(ChatModel.fromJson(item));
      }

      status = Status.completed;
      update();
    });
  }

  /// Create chat function
  Future<void> createChat(String participantId) async {
    try {
      status = Status.loading;
      update();

      var response = await ApiService.post(ApiEndPoint.createChat, body: {
        "participants": [participantId]
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final chatPayload = response.data['chat'] ?? response.data['data'] ?? {};
        final participants = List.from(chatPayload['participants'] ?? []);
        final anotherParticipant = chatPayload['anotherParticipant'] ?? {};

        final String chatId = chatPayload['_id'] ?? '';
        final String participantName =
            anotherParticipant['name'] ?? anotherParticipant['fullName'] ?? '';
        final String participantImage = anotherParticipant['image'] ?? '';
        final String participantFallbackId =
            anotherParticipant['_id'] ?? (participants.isNotEmpty ? participants.first : '');

        if (chatId.isEmpty || participantFallbackId.isEmpty) {
          Utils.errorSnackBar('Chat', 'Invalid chat information returned from server');
          status = Status.error;
          update();
          return;
        }
        
        // Navigate to message screen with the new chat
        Get.toNamed(
          AppRoutes.message,
          parameters: {
            "chatId": chatId,
            "name": participantName,
            "image": participantImage,
          },
        );
        
        status = Status.completed;
        update();
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
        status = Status.error;
        update();
      }
    } catch (e) {
      Utils.errorSnackBar('Error', 'Failed to create chat: $e');
      status = Status.error;
      update();
    }
  }

  /// Controller on Init¬
  @override
  void onInit() {
    getChatRepo();
    super.onInit();
  }

  List<ChatModel> _parseChatList(dynamic data) {
    final chatList = _extractChatList(data);

    return chatList
        .whereType<Map<String, dynamic>>()
        .map(_normalizeChatJson)
        .map(ChatModel.fromJson)
        .toList();
  }

  List _extractChatList(dynamic data) {
    if (data is List) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      final dataField = data['data'];
      if (dataField != null) {
        final nested = _extractChatList(dataField);
        if (nested.isNotEmpty) return nested;
      }

      final chatsField = data['chats'];
      if (chatsField != null) {
        final nested = _extractChatList(chatsField);
        if (nested.isNotEmpty) return nested;
      }

      final resultsField = data['results'];
      if (resultsField != null) {
        final nested = _extractChatList(resultsField);
        if (nested.isNotEmpty) return nested;
      }
    }

    return [];
  }

  Map<String, dynamic> _normalizeChatJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);

    if (normalized['participant'] == null &&
        normalized['anotherParticipant'] is Map<String, dynamic>) {
      final another = Map<String, dynamic>.from(normalized['anotherParticipant']);
      normalized['participant'] = {
        "_id": another['_id'] ?? '',
        "fullName": another['name'] ?? another['fullName'] ?? '',
        "image": another['image'] ?? '',
      };
    }

    if (normalized['participant'] == null &&
        normalized['participants'] is List &&
        (normalized['participants'] as List).isNotEmpty) {
      final first = Map<String, dynamic>.from(
        (normalized['participants'] as List).first as Map<String, dynamic>,
      );
      normalized['participant'] = {
        "_id": first['_id'] ?? first['id'] ?? '',
        "fullName": first['name'] ?? first['fullName'] ?? '',
        "image": first['image'] ?? first['profileImage'] ?? '',
      };
    }

    if (normalized['latestMessage'] == null && normalized['lastMessage'] != null) {
      normalized['latestMessage'] = normalized['lastMessage'];
    }

    if (normalized['latestMessage'] == null) {
      final updatedAt = normalized['updatedAt']?.toString();
      normalized['latestMessage'] = {
        "_id": '',
        "message": '',
        "createdAt": updatedAt ?? DateTime.now().toIso8601String(),
      };
    }

    return normalized;
  }
}
