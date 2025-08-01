import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/Errors/error_handler.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/model/conversation_model.dart';

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository(ref.read(dioServiceProvider));
});

class HomeRepository {
  final Dio _dio;

  HomeRepository(Dio dio) : _dio = dio;

  FutureEither<List<Conversation>> getConversations(String? sender) async {
    try {
      if (sender == null || sender.isEmpty) {
        return left(Failure("Not logged id"));
      }
      final response = await _dio.get(ApiConstants.getConversations);
      List<Conversation> conversations = [];
      if (response.statusCode == 200) {
        final data = response.data['conversation'] as List;

        for (var value in data) {
          Conversation conversation = Conversation.fromJson(value);
          conversations.add(conversation);
        }

        return right(conversations);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }
}
