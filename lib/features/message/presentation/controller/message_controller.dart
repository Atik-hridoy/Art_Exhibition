import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  List<ChatMessageModel> messages = [];

  String chatId = "";
  String name = "";

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;

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
          await ApiService.get("${ApiEndPoint.sendMessage}/$chatId?page=$page&limit=20");

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
      final response = await ApiService.post(
        ApiEndPoint.sendMessage,
        body: {
          "chat": chatId,
          "text": text,
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
      }
      await getMessageRepo(refresh: true);
    } catch (e) {
      Utils.errorSnackBar('Message', 'Failed to send message');
    } finally {
      isMessage = false;
      update();
    }
  }

  listenMessage(String chatId) async {
    SocketServices.on('new-message::$chatId', (data) {
      final createdAtStr = data['createdAt']?.toString();
      final createdAt =
          DateTime.tryParse(createdAtStr ?? '') ?? DateTime.now();
      messages.insert(
        0,
        ChatMessageModel(
          isNotice: data['messageType'] == "notice" ? true : false,
          time: createdAt,
          text: data['message'],
          image: data['sender']['image'],
          isMe: false,
        ),
      );

      update();
    });
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
    return ChatMessageModel(
      time: message.createdAt.toLocal(),
      text: message.message,
      image: message.sender.image,
      isNotice: message.type == "notice",
      isMe: LocalStorage.userId == message.sender.id,
    );
  }
}
