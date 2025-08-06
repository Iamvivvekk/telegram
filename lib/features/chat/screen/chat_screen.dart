import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/Errors/error_screen.dart';
import 'package:telegram/core/common/extensions/context_extensions.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/features/chat/controller/chat_repository_controller.dart';
import 'package:telegram/features/chat/widgets/chat_screen_appbar.dart';
import 'package:telegram/features/chat/widgets/message_field.dart';
import 'package:telegram/features/chat/widgets/my_message_card.dart';
import 'package:telegram/features/chat/widgets/sender_message_card.dart';
import 'package:telegram/model/conversation_model.dart';
import 'package:telegram/providers/user_data_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversation});
  final Conversation conversation;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImageConstants.chatBg,
            fit: BoxFit.cover,
            color: AppColor.whiteSecondary,
            height: context.screenHeight,
            width: context.screenWidth,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: kToolbarHeight + context.safeAreaHeight),
                  Consumer(
                    builder: (_, ref, child) {
                      final myId = ref.read(userDataProvider)!.uid;
                      return ref
                          .watch(
                            chatRepositoryControllerProvider(
                              widget.conversation.participants.last.id,
                            ),
                          )
                          .when(
                            data: (chats) {
                              if (chats == null || chats.isEmpty) {
                                return const Expanded(
                                  child: Center(child: Text("chats are null")),
                                );
                              }
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_scrollController.hasClients) {
                                  _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent,
                                  );
                                  
                                }
                              });
                              return Expanded(
                                child: ListView.builder(
                                  // reverse: true,
                                  controller: _scrollController,

                                  padding: const EdgeInsets.only(bottom: 8),
                                  itemCount: chats.length,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: index == 17
                                          ? EdgeInsetsGeometry.only(
                                              top:
                                                  kToolbarHeight +
                                                  context.safeAreaHeight,
                                            )
                                          : const EdgeInsetsGeometry.only(
                                              top: 0,
                                            ),
                                      child: chats[index].sender == myId
                                          ? MyMessageCard(chats[index])
                                          : SenderMessageCard(chats[index]),
                                    );
                                  },
                                ),
                              );
                            },
                            error: (e, s) {
                              return ErrorScreen(e.toString());
                            },
                            loading: () {
                              return const Loader();
                            },
                          );
                    },
                  ),
                  MessageField(
                    participant: widget.conversation.participants.first,
                  ),
                ],
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ChatScreenAppbar(
                    fullName:
                        widget.conversation.participants.first.id ==
                            ref.read(userDataProvider)!.uid
                        ? widget.conversation.participants.last.fullName
                        : widget.conversation.participants.first.fullName,
                    photoUrl: widget.conversation.participants.last.photoUrl,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
