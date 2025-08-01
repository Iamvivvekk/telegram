import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/features/chat/repository/chat_repository.dart';
import 'package:telegram/model/chat_model.dart';
import 'package:telegram/providers/user_data_provider.dart';

final chatRepositoryControllerProvider =
    AsyncNotifierProviderFamily<ChatRepositoryController, List<Chat>?, String>(
      () => ChatRepositoryController(),
    );

class ChatRepositoryController
    extends FamilyAsyncNotifier<List<Chat>?, String> {
  @override
  FutureOr<List<Chat>?> build(String sender) async {
    return await fetchAllChats(sender);
  }

  Future<List<Chat>?> fetchAllChats(String sender) async {
    final chatRepository = ref.read(chatRepositoryProvider);
    final result = await chatRepository.fetchAllChats(sender);
    return result.fold(
      (error) {
        state = const AsyncValue.data(null);
        log(error.message);
        return state.value;
      },
      (chats) {
        log(chats.toString());
        state = AsyncValue.data(chats);
        return chats;
      },
    );
  }

  ChatRepositoryController() : super();

  Future<void> sendMessage({
    required String receiver,
    required String? message,
  }) async {
    final sender = ref.read(userDataProvider)!.uid;
    log("$sender\t$receiver");
    final result = await ref
        .read(chatRepositoryProvider)
        .sendMessage(sender: sender, receiver: receiver, message: message);

    result.fold((error) {}, (chat) {
      AsyncValue.data(
        [
          ...state.value!,
          chat,
        ].sort((a, b) => a.createdAt.compareTo(b.createdAt)),
      );
    });
  }
}
