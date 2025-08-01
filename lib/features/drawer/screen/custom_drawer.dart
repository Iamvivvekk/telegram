import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/size.dart';
import 'package:telegram/features/drawer/controller/drawer_controller.dart';

import '../../../providers/user_data_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileItem = ref.read(drawerControllerProvider).tileItem;
    final size = ScreenUtil.getSize(context);
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      width: size.width * 0.75,
      child: Container(
        color: AppColor.drawerBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(userDataProvider);
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 190,
                    maxHeight: 210,
                  ),
                  child: Container(
                    height: size.height * 0.21,
                    color: AppColor.appBarColor,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 60,
                      bottom: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColor.blueText,
                              foregroundImage: user!.profilePic != null
                                  ? CachedNetworkImageProvider(user.profilePic!)
                                  : const AssetImage(
                                      ImageConstants.profileDefault,
                                    ),
                            ),
                            const Icon(Icons.sunny),
                          ],
                        ),
                        const HeightSpacer(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ref.watch(userDataProvider)?.name ??
                                      " No name",
                                  style: const TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const HeightSpacer(height: 8),
                                Text(
                                  "${ref.watch(userDataProvider)?.mobile ?? "No name"}",
                                  style: const TextStyle(
                                    color: AppColor.greyText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 32,
                              color: AppColor.greyText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: List.generate(tileItem.length, (index) {
                  return ListTile(
                    onTap: () => ref
                        .read(drawerControllerProvider)
                        .drawerOnTap(index, context),
                    leading: Icon(
                      tileItem[index].icon,
                      color: AppColor.greyText,
                      size: 24,
                    ),
                    title: Text(
                      tileItem[index].title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteSecondary,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
