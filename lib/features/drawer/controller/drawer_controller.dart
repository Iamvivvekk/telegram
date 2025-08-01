import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/model/drawer_tile_item.dart';

final drawerControllerProvider = Provider((ref) {
  return DrawerController();
});

class DrawerController {
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
  void drawerOnTap(int index, BuildContext context) {
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
        context.pushNamed(RouteNames.settings);
        break;
      case 6:
        break;
      case 7:
        break;

      default:
        context.pop(context);
    }
  }
}
