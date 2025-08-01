import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/features/home/repository/home_repository.dart';
import 'package:telegram/model/conversation_model.dart';
import 'package:telegram/providers/user_data_provider.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<Conversation>?>(
      () => HomeController(),
    );

class HomeController extends AsyncNotifier<List<Conversation>?> {
  @override
  FutureOr<List<Conversation>?> build() async {
    return await getConversation();
  }

  Future<List<Conversation>?> getConversation() async {
    final homeRepo = ref.read(homeRepositoryProvider);
    final senderId = ref.read(userDataProvider)?.uid;
    final result = await homeRepo.getConversations(senderId);
    return result.fold(
      (error) {
        state = AsyncValue.error(error.message, StackTrace.current);
        log(error.message);
        return null;
      },
      (conversations) {
        state = AsyncValue.data(conversations);
        return state.value;
      },
    );
  }
}
