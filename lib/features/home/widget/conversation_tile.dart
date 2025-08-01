import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/common/widgets/width_spcer.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/model/conversation_model.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({super.key, required this.conversation});
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteNames.chat,
        extra: {"conversation": conversation},
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: AppColor.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.blueText,
                      backgroundImage:
                          conversation.participants.last.photoUrl.isNotEmpty
                          ? CachedNetworkImageProvider(
                              conversation.participants.last.photoUrl,
                            )
                          : const AssetImage(ImageConstants.profileDefault),
                    ),
                    const WidthSpacer(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          conversation.participants.last.fullName,
                          fontWeight: FontWeight.bold,
                        ),
                        const ReusableText("Last Message", fontsize: 10),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ReusableText(
                      "${conversation.updatedAt.day}-${conversation.updatedAt.month}-${conversation.updatedAt.year}",
                      fontsize: 12,
                    ),
                    const HeightSpacer(height: 6),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: AppColor.blueSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: ReusableText("1", fontsize: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const HeightSpacer(),
            const Divider(
              indent: 52,
              color: AppColor.black,
              thickness: 0.0,
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
