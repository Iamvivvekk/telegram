import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/services/socket_services.dart';
import 'package:telegram/features/chat/repository/chat_repository.dart';
import 'package:telegram/features/chat/repository/message_stream.dart';
import 'package:telegram/model/message_model.dart';
import 'package:telegram/providers/user_data_provider.dart';

final chatRepositoryControllerProvider =
    AsyncNotifierProviderFamily<
      ChatRepositoryController,
      List<Message>?,
      String
    >(() => ChatRepositoryController(socketService: SocketServices()));

class ChatRepositoryController
    extends FamilyAsyncNotifier<List<Message>?, String> {
  final SocketServices socketService;
  @override
  FutureOr<List<Message>?> build(String sender) async {
    return await loadMessages(sender);
  }

  Future<List<Message>?> loadMessages(String sender) async {
    final chatRepository = ref.read(chatRepositoryProvider);
    final result = await chatRepository.loadMessages(sender);
    return result.fold(
      (error) {
        state = const AsyncValue.data(null);
        log(error.message);
        return state.value;
      },
      (chats) {
        state = AsyncValue.data(chats);
        socketService.socket.emit("getMessage", state.value!.last.toJson());
        return chats;
      },
    );
  }

  ChatRepositoryController({required this.socketService}) : super();

  Future<void> sendMessage({
    required String receiver,
    required String? message,
  }) async {
    final sender = ref.read(userDataProvider)!.uid;
    final result = await ref
        .read(chatRepositoryProvider)
        .sendMessage(sender: sender, receiver: receiver, message: message);

    result.fold(
      (error) {
        debugPrint(error.message);
      },
      (chat) {
        final newData = AsyncValue.data(
          [...state.value!, chat],
          // .sort((a, b) => a.createdAt.compareTo(b.createdAt)),
        );
        state = newData;
      },
    );
  }

  void getMessages() async {
    final message = MessageStream.instance();
    state = AsyncValue.data([...state.value!, await message.getResponse.first]);
  }
}
