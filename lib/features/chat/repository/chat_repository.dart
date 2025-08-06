import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/Errors/error_handler.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/services/socket_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/features/chat/repository/message_stream.dart';
import 'package:telegram/model/message_model.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
    dio: ref.read(dioServiceProvider),
    ref: ref,
    socketService: SocketServices(),
  );
});

class ChatRepository {
  final Dio _dio;
  final Ref ref;
  final SocketServices socketService;

  ChatRepository({
    required Dio dio,
    required this.ref,
    required this.socketService,
  }) : _dio = dio;

  FutureEither<List<Message>> loadMessages(String sender) async {
    try {
      final response = await _dio.get("${ApiConstants.getChats}/$sender");

      if (response.statusCode == 200) {
        final List<Message> chats = (response.data['messageData'] as List)
            .map((chat) => Message.fromJson(chat))
            .toList();
        return right(chats);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }

  FutureEither<Message> sendMessage({
    String? message,
    File? file,
    required String sender,
    required String receiver,
  }) async {
    try {
      final response = await _dio.post(
        "${ApiConstants.sendMessage}/$receiver",
        data: jsonEncode({"message": message}),
      );

      final socket = SocketServices();
      socket.socket.on("send-message", (message) {
        final myMessage = Message.fromJson(jsonDecode(jsonEncode(message)));
        return right(myMessage);
      });

      if (response.statusCode == 201) {
        final chat = Message.fromJson(response.data['message']);
        return right(chat);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }

  void getMessageStream() {
    MessageStream messageStream = MessageStream.instance();
    socketService.socket.on("message", (msg) {
      final message = Message.fromJson(jsonDecode(jsonEncode(msg)));

      messageStream.addResponse(message);
    });
  }
}
