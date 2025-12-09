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
  bool hasMore = true;

  /// page no here
  int page = 1;

  /// Chat List here
  List<ChatModel> chats = [];

  /// Chat Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Chat Controller Instance create here
  static ChatController get instance => Get.put(ChatController());
  bool _isListeningSocket = false;

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
  Future<void> getChatRepo({bool refresh = false}) async {
    try {
      if (refresh) {
        page = 1;
        hasMore = true;
        chats.clear();
      }

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
    if (_isListeningSocket) {
      print("ChatController: Already listening for socket events");
      return;
    }
    _isListeningSocket = true;
    final userId = LocalStorage.userId;
    print("ChatController: Setting up socket listeners for userId: $userId");
    
    final events = [
      "chatListUpdate::$userId",
      "newChat::$userId",
    ];

    for (final event in events) {
      print("ChatController: Setting up listener for event: $event");
      SocketServices.on(event, (data) async {
        print("ChatController: Socket event received: $event");
        print("ChatController: Socket data: $data");
        
        if (data == null) {
          print("ChatController: No data received, refreshing chat list from API");
          await getChatRepo(refresh: true);
          return;
        }

        if (data is List) {
          print("ChatController: Data is List with ${data.length} items");
          final incoming = data
              .whereType<Map<String, dynamic>>()
              .map(_normalizeChatJson)
              .map(ChatModel.fromJson)
              .toList();

          print("ChatController: Parsed ${incoming.length} valid chats from list");
          if (incoming.isNotEmpty) {
            print("ChatController: Chat list before update: ${chats.length} items");
            chats
              ..clear()
              ..addAll(_sortChatsByLatest(incoming));
            print("ChatController: Chat list after update: ${chats.length} items");
            print("ChatController: First chat ID: ${chats.isNotEmpty ? chats.first.id : 'none'}");
            status = Status.completed;
            update();
            print("ChatController: UI update() called");
            return;
          } else {
            print("ChatController: No valid chats parsed from incoming data");
          }
        }

        if (data is Map<String, dynamic>) {
          print("ChatController: Single chat data received, updating/inserting");
          _upsertChatFromSocket(data);
        } else {
          print("ChatController: Unexpected data format, refreshing from API");
          await getChatRepo(refresh: true);
        }
      });
    }
    
    print("ChatController: All socket listeners setup complete");
  }

  void _upsertChatFromSocket(Map<String, dynamic> payload) {
    print("ChatController: _upsertChatFromSocket called with payload: $payload");
    
    // Extract the actual chat data from the nested structure
    Map<String, dynamic> chatData;
    if (payload['chat'] is Map<String, dynamic>) {
      chatData = Map<String, dynamic>.from(payload['chat']);
      // Copy the latestMessage from the root if it exists
      if (payload['lastMessage'] != null) {
        chatData['lastMessage'] = payload['lastMessage'];
        chatData['latestMessage'] = payload['lastMessage'];
      }
    } else {
      chatData = Map<String, dynamic>.from(payload);
    }
    
    final normalized = _normalizeChatJson(chatData);
    print("ChatController: Normalized payload: $normalized");
    final updatedChat = ChatModel.fromJson(normalized);
    print("ChatController: Parsed chat - ID: ${updatedChat.id}, Latest: ${updatedChat.latestMessage.message}");

    final existingIndex = chats.indexWhere((chat) => chat.id == updatedChat.id);
    print("ChatController: Existing chat index: $existingIndex (current chats: ${chats.length})");
    
    if (existingIndex != -1) {
      print("ChatController: Removing existing chat at index $existingIndex");
      chats.removeAt(existingIndex);
    }
    
    chats.insert(0, updatedChat);
    print("ChatController: Inserted chat at position 0");
    
    chats
      ..removeWhere((chat) => chat.id.isEmpty)
      ..setAll(0, _sortChatsByLatest(chats));
    
    print("ChatController: Final chat list length: ${chats.length}");
    print("ChatController: Top chat now: ${chats.isNotEmpty ? chats.first.participant.fullName : 'none'}");
    
    status = Status.completed;
    update();
    print("ChatController: UI update() called from _upsertChatFromSocket");
  }

  List<ChatModel> _sortChatsByLatest(List<ChatModel> source) {
    source.sort(
      (a, b) => b.latestMessage.createdAt.compareTo(a.latestMessage.createdAt),
    );
    return source;
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
    listenChat();
    super.onInit();
  }

  List<ChatModel> _parseChatList(dynamic data) {
    final chatList = _extractChatList(data);

    return _sortChatsByLatest(
      chatList
        .whereType<Map<String, dynamic>>()
        .map(_normalizeChatJson)
        .map(ChatModel.fromJson)
        .toList(),
    );
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
