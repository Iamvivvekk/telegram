// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Chat({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"],
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
