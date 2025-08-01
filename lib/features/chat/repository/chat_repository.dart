import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/Errors/error_handler.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/model/chat_model.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(dio: ref.read(dioServiceProvider));
});

class ChatRepository {
  final Dio _dio;

  ChatRepository({required Dio dio}) : _dio = dio;

  FutureEither<List<Chat>> fetchAllChats(String sender) async {
    try {
      final response = await _dio.get("${ApiConstants.getChats}/$sender");
      if (response.statusCode == 200) {
        final List<Chat> chats = (response.data['messageData'] as List).map((
          chat,
        ) {
          log(chat);
          return Chat.fromJson(chat);
        }).toList();
        log(chats.toString());
        return right(chats);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }

  FutureEither<Chat> sendMessage({
    String? message,
    File? file,
    required String sender,
    required String receiver,
  }) async {
    try {
      // if(!file)
      final response = await _dio.post(
        "${ApiConstants.sendMessage}/$receiver",
        data: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final chat = Chat.fromJson(response.data['']);
        return right(chat);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }
}
