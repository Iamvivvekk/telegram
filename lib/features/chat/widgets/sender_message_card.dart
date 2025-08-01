import 'package:flutter/material.dart';
import 'package:telegram/core/common/extensions/context_extensions.dart';
import 'package:telegram/core/common/extensions/date_extensions.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/model/chat_model.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard(this.chat, {super.key});
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: context.screenWidth * 0.85,
          minHeight: 40,
        ),
        child: Container(
          //  alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.appBarColor.withAlpha(240),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
              right: Radius.circular(20),
            ),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: ReusableText(chat.message, maxLines: null)),
              const SizedBox(width: 3),
              ReusableText(chat.createdAt.toLocal().toTime  , fontsize: 8),
              const SizedBox(width: 3),
            ],
          ),
        ),
      ),
    );
  }
}
