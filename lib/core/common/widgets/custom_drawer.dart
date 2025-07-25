import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/size.dart';
import 'package:telegram/model/drawer_tile_item.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DrawerTileItem> tileItem = [
      DrawerTileItem(title: "My Profile", icon: Icons.person),
      DrawerTileItem(title: "New Group", icon: Icons.people),
      DrawerTileItem(title: "Contacts", icon: Icons.person_outline),
      DrawerTileItem(title: "Calls", icon: Icons.call),
      DrawerTileItem(title: "Saved Messages", icon: Icons.save_alt),
      DrawerTileItem(title: "Settings", icon: Icons.settings),
      DrawerTileItem(title: "Invite Friends", icon: Icons.person_add_alt),
      DrawerTileItem(title: "Telegram Features", icon: Icons.question_mark),
    ];
    final size = ScreenUtil.getSize(context);
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      width: size.width * 0.75,
      child: Container(
        color: AppColor.drawerBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 190, maxHeight: 210),
              child: Container(
                height: size.height * 0.21,
                color: AppColor.appBarColor,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 60, bottom: 12),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColor.blueText,
                        ),
                        Icon(Icons.sunny)
                      ],
                    ),
                    HeightSpacer(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vivek",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            HeightSpacer(height: 8),
                            Text(
                              "+91 9876543210",
                              style: TextStyle(
                                color: AppColor.greyText,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                          color: AppColor.greyText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: List.generate(
                  tileItem.length,
                  (index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            break;
                          case 1:
                            break;
                          case 2:
                            break;
                          case 3:
                            break;
                          case 4:
                            break;
                          case 5:
                            break;
                          case 6:
                            break;
                          case 7:
                            break;

                          default:
                            context.pop(context);
                        }
                      },
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
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
