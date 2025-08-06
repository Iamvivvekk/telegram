import 'package:flutter/material.dart';
import 'package:telegram/core/common/extensions/context_extensions.dart';
import 'package:telegram/core/common/extensions/date_extensions.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/model/message_model.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard(this.chat, {super.key});
  final Message chat;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.screenWidth * 0.85,
          minHeight: 40,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.error.withAlpha(80),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(12),
            ),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: ReusableText(chat.message)),
              const SizedBox(width: 6),
              ReusableText(chat.createdAt.toLocal().toTime, fontsize: 8),
              const SizedBox(width: 6),
              const Icon(Icons.check, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}
