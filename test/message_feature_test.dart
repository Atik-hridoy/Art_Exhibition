import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tasaned_project/features/message/data/model/chat_message_model.dart';
import 'package:tasaned_project/features/message/data/model/message_model.dart';
import 'package:tasaned_project/features/message/presentation/controller/message_controller.dart';

void main() {
  group('ChatMessageModel Tests', () {
    test('ChatMessageModel should be created with correct properties', () {
      final now = DateTime.now();
      final message = ChatMessageModel(
        time: now,
        text: 'Test message',
        image: 'https://test.com/image.jpg',
        isMe: true,
        isCall: false,
        isNotice: false,
      );

      expect(message.time, equals(now));
      expect(message.text, equals('Test message'));
      expect(message.image, equals('https://test.com/image.jpg'));
      expect(message.isMe, equals(true));
      expect(message.isCall, equals(false));
      expect(message.isNotice, equals(false));
    });

    test('ChatMessageModel should have default values for optional parameters', () {
      final now = DateTime.now();
      final message = ChatMessageModel(
        time: now,
        text: 'Test message',
        image: 'https://test.com/image.jpg',
        isMe: false,
      );

      expect(message.isCall, equals(false));
      expect(message.isNotice, equals(false));
    });
  });

  group('MessageModel Tests', () {
    test('MessageModel fromJson should parse correctly', () {
      final json = {
        '_id': '123',
        'chat': 'chat123',
        'message': 'Hello World',
        'type': 'general',
        'sender': {
          '_id': 'sender123',
          'fullName': 'John Doe',
          'image': 'https://test.com/avatar.jpg',
        },
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-01T10:00:00.000Z',
        '__v': 0,
      };

      final messageModel = MessageModel.fromJson(json);

      expect(messageModel.id, equals('123'));
      expect(messageModel.chat, equals('chat123'));
      expect(messageModel.message, equals('Hello World'));
      expect(messageModel.type, equals('general'));
      expect(messageModel.sender.id, equals('sender123'));
      expect(messageModel.sender.fullName, equals('John Doe'));
      expect(messageModel.sender.image, equals('https://test.com/avatar.jpg'));
      expect(messageModel.version, equals(0));
    });

    test('MessageModel should handle empty json', () {
      final messageModel = MessageModel.fromJson({});

      expect(messageModel.id, equals(''));
      expect(messageModel.chat, equals(''));
      expect(messageModel.message, equals(''));
      expect(messageModel.type, equals('general'));
      expect(messageModel.sender.id, equals(''));
      expect(messageModel.sender.fullName, equals(''));
      expect(messageModel.sender.image, equals(''));
      expect(messageModel.version, equals(0));
    });

    test('MessageModel toJson should serialize correctly', () {
      final sender = Sender(
        id: 'sender123',
        fullName: 'John Doe',
        image: 'https://test.com/avatar.jpg',
      );

      final messageModel = MessageModel(
        id: '123',
        chat: 'chat123',
        message: 'Hello World',
        type: 'general',
        sender: sender,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        version: 0,
      );

      final json = messageModel.toJson();

      expect(json['_id'], equals('123'));
      expect(json['chat'], equals('chat123'));
      expect(json['message'], equals('Hello World'));
      expect(json['type'], equals('general'));
      final senderJson = json['sender'] as Map<String, dynamic>?;
      expect(senderJson!['_id'], equals('sender123'));
      expect(senderJson['fullName'], equals('John Doe'));
      expect(senderJson['image'], equals('https://test.com/avatar.jpg'));
      expect(json['__v'], equals(0));
    });
  });

  group('Sender Tests', () {
    test('Sender fromJson should parse correctly', () {
      final json = {
        '_id': 'sender123',
        'fullName': 'Jane Smith',
        'image': 'https://test.com/jane.jpg',
      };

      final sender = Sender.fromJson(json);

      expect(sender.id, equals('sender123'));
      expect(sender.fullName, equals('Jane Smith'));
      expect(sender.image, equals('https://test.com/jane.jpg'));
    });

    test('Sender should handle empty json', () {
      final sender = Sender.fromJson({});

      expect(sender.id, equals(''));
      expect(sender.fullName, equals(''));
      expect(sender.image, equals(''));
    });

    test('Sender toJson should serialize correctly', () {
      final sender = Sender(
        id: 'sender123',
        fullName: 'Jane Smith',
        image: 'https://test.com/jane.jpg',
      );

      final json = sender.toJson();

      expect(json['_id'], equals('sender123'));
      expect(json['fullName'], equals('Jane Smith'));
      expect(json['image'], equals('https://test.com/jane.jpg'));
    });
  });

  group('MessageController Tests', () {
    late MessageController controller;

    setUp(() {
      // Initialize GetX
      Get.testMode = true;
      controller = MessageController();
    });

    tearDown(() {
      Get.reset();
    });

    test('MessageController should initialize with default values', () {
      expect(controller.isLoading, equals(false));
      expect(controller.isMoreLoading, equals(false));
      expect(controller.messages.length, equals(2)); // Default messages
      expect(controller.chatId, equals(''));
      expect(controller.name, equals(''));
      expect(controller.page, equals(1));
      expect(controller.isMessage, equals(false));
      expect(controller.isInputField, equals(false));
    });

    test('MessageController should have default messages', () {
      expect(controller.messages.length, greaterThanOrEqualTo(2));
      expect(controller.messages[0].text, isNotEmpty);
      expect(controller.messages[0].isMe, isA<bool>());
    });

    test('addNewMessage should add message to list when text is not empty', () {
      controller.messageController.text = 'New test message';
      final initialLength = controller.messages.length;

      controller.addNewMessage();

      expect(controller.messages.length, equals(initialLength + 1));
      expect(controller.messages[0].text, equals('New test message'));
      expect(controller.messages[0].isMe, equals(true));
      expect(controller.messageController.text, equals(''));
    });

    test('MessageController should update chatId and name', () {
      controller.chatId = 'test-chat-123';
      controller.name = 'Test User';

      expect(controller.chatId, equals('test-chat-123'));
      expect(controller.name, equals('Test User'));
    });

    test('ScrollController should be initialized', () {
      expect(controller.scrollController, isNotNull);
      expect(controller.scrollController, isA<ScrollController>());
    });

    test('TextEditingController should be initialized', () {
      expect(controller.messageController, isNotNull);
      expect(controller.messageController, isA<TextEditingController>());
    });

    test('MessageController should manage isMessage flag', () {
      expect(controller.isMessage, equals(false));
      
      controller.isMessage = true;
      expect(controller.isMessage, equals(true));
      
      controller.isMessage = false;
      expect(controller.isMessage, equals(false));
    });

    test('isEmoji should update currentIndex and isInputField', () {
      controller.isEmoji(5);
      expect(controller.currentIndex, equals(5));
    });

    test('MessageController page should increment', () {
      final initialPage = controller.page;
      controller.page = controller.page + 1;
      
      expect(controller.page, equals(initialPage + 1));
    });
  });

  group('Message Integration Tests', () {
    test('Full message flow - create, serialize, deserialize', () {
      // Create a message
      final originalJson = {
        '_id': '999',
        'chat': 'integration-chat',
        'message': 'Integration test message',
        'type': 'general',
        'sender': {
          '_id': 'sender999',
          'fullName': 'Test User',
          'image': 'https://test.com/user.jpg',
        },
        'createdAt': '2024-01-15T12:00:00.000Z',
        'updatedAt': '2024-01-15T12:00:00.000Z',
        '__v': 0,
      };

      // Parse from JSON
      final messageModel = MessageModel.fromJson(originalJson);

      // Verify parsed data
      expect(messageModel.message, equals('Integration test message'));
      expect(messageModel.sender.fullName, equals('Test User'));

      // Serialize back to JSON
      final serializedJson = messageModel.toJson();

      // Verify serialized data matches original
      expect(serializedJson['_id'], equals(originalJson['_id']));
      expect(serializedJson['message'], equals(originalJson['message']));
      final serializedSender = serializedJson['sender'] as Map<String, dynamic>?;
      final originalSender = originalJson['sender'] as Map<String, dynamic>?;
      expect(serializedSender!['fullName'], equals(originalSender!['fullName']));
    });

    test('ChatMessage should be created from MessageModel', () {
      final messageModel = MessageModel.fromJson({
        '_id': '123',
        'chat': 'chat123',
        'message': 'Test message',
        'type': 'general',
        'sender': {
          '_id': 'sender123',
          'fullName': 'John Doe',
          'image': 'https://test.com/avatar.jpg',
        },
        'createdAt': '2024-01-01T10:00:00.000Z',
        'updatedAt': '2024-01-01T10:00:00.000Z',
        '__v': 0,
      });

      final chatMessage = ChatMessageModel(
        time: messageModel.createdAt.toLocal(),
        text: messageModel.message,
        image: messageModel.sender.image,
        isMe: false,
      );

      expect(chatMessage.text, equals(messageModel.message));
      expect(chatMessage.image, equals(messageModel.sender.image));
      expect(chatMessage.isMe, equals(false));
    });
  });
}
