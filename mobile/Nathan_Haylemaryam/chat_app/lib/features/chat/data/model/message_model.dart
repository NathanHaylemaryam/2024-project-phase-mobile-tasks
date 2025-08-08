// lib/features/chat/data/models/message_model.dart
import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required String id,
    required String chatId,
    required String senderId,
    required String content,
    required String type,
    required DateTime createdAt,
  }) : super(
    id: id,
    chatId: chatId,
    senderId: senderId,
    content: content,
    type: type,
    createdAt: createdAt,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      chatId: json['chat']['_id'],
      senderId: json['sender']['_id'],
      content: json['content'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'content': content,
      'type': type,
    };
  }
}