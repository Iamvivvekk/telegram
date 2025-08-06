// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Conversation conversationFromJson(String str) =>
    Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  final String id;
  final List<Participant> participants;
  final bool? isOnline;
  final List<String> message;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.participants,
    required this.message,
    this.isOnline ,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    participants: List<Participant>.from(
      json["participants"].map((x) => Participant.fromJson(x)),
    ),
    message: List<String>.from(json["message"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "message": List<dynamic>.from(message.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };

  Conversation copyWith({
    String? id,
    List<Participant>? participants,
    bool? isOnline,
    List<String>? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      isOnline: isOnline ?? this.isOnline,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Participant {
  final String id;
  final int mobile;
  final String fullName;
  final String photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Participant({
    required this.id,
    required this.mobile,
    required this.fullName,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    mobile: json["mobile"],
    fullName: json["fullName"],
    photoUrl: json["photoUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mobile": mobile,
    "fullName": fullName,
    "photoUrl": photoUrl,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
