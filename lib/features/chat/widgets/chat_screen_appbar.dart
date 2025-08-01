import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/extensions/context_extensions.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/reusable_text.dart';

class ChatScreenAppbar extends ConsumerWidget {
  const ChatScreenAppbar({super.key, required this.fullName, this.photoUrl});
  final String fullName;
  final String? photoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColor.appBarColor.withAlpha(253),
      // color: Colors.transparent,
      height: context.safeAreaHeight + kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.safeAreaHeight),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 18),
                      CircleAvatar(
                        backgroundColor: AppColor.greyText,
                        backgroundImage: photoUrl == null || photoUrl!.isEmpty
                            ? const AssetImage(ImageConstants.profileDefault)
                            : CachedNetworkImageProvider(photoUrl!),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(fullName, fontsize: 14),
                          const ReusableText(
                            "Offline",
                            fontsize: 10,
                            color: AppColor.blueSecondary,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ],
      ),
    );
  }
}
