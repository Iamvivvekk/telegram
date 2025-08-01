import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/features/chat/controller/chat_repository_controller.dart';
import 'package:telegram/features/chat/controller/show_send_provider.dart';
import 'package:telegram/model/conversation_model.dart';
import 'package:telegram/providers/user_data_provider.dart';

class MessageField extends ConsumerStatefulWidget {
  const MessageField(this.participant, {super.key, required this.jumpTo});
  final Participant participant;
  final VoidCallback jumpTo;

  @override
  ConsumerState<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends ConsumerState<MessageField> {
  final TextEditingController messageFieldController = TextEditingController();
  get fieldBorder => const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.zero,
  );

  void sendMessage() {
    {
      ref.read(showSendButtonProvider.notifier).update((cb) => false);
      final myId = ref.read(userDataProvider)!.uid;
      ref
          .read(chatRepositoryControllerProvider(myId).notifier)
          .sendMessage(
            receiver: widget.participant.id,
            message: messageFieldController.text.trim(),
          );
      messageFieldController.clear();
      // widget.jumpTo();
    }
  }

  @override
  void dispose() {
    messageFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: TextFormField(
        controller: messageFieldController,
        cursorWidth: 1,
        cursorHeight: 18,
        cursorColor: AppColor.blueSecondary,
        onSaved: (v) => sendMessage(),
        onFieldSubmitted: (v) => sendMessage(),

        onChanged: (val) {
          if (val.isEmpty) {
            ref.read(showSendButtonProvider.notifier).update((cb) => false);
          } else {
            ref.read(showSendButtonProvider.notifier).update((cb) => true);
          }
        },
        minLines: 1,
        maxLines: 6,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          fillColor: AppColor.appBarColor,

          filled: true,
          border: fieldBorder,
          enabledBorder: fieldBorder,
          focusedBorder: fieldBorder,
          hintText: "Message",
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColor.greyText.withAlpha(120),
            // fo,
          ),
          prefixIcon: GestureDetector(
            onTap: sendMessage,
            child: const Icon(Icons.emoji_emotions_outlined),
          ),
          suffixIcon: Container(
            // alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 16),
            child: Consumer(
              builder: (context, ref, child) {
                final showSend = ref.watch(showSendButtonProvider);
                return showSend == false
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(ImageConstants.attatchment, height: 28),
                          Image.asset(ImageConstants.mic, height: 32),
                        ],
                      )
                    : GestureDetector(
                        onTap: sendMessage,
                        child: const Icon(
                          Icons.send,
                          color: AppColor.blueSecondary,
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
