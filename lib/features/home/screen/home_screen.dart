import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/Errors/error_screen.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/features/drawer/screen/custom_drawer.dart';
import 'package:telegram/features/home/controller/home_controller.dart';
import 'package:telegram/features/home/widget/conversation_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {}

  @override
  Widget build(BuildContext context) {
    // final s = HomeSocketRepository(ref.watch(socketProvider).value!);
    // s.getOnlineStatus();
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const ReusableText("Telegram", fontsize: 18),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.pushNamed(RouteNames.search),
          ),
        ],
      ),
      body: ref
          .watch(homeControllerProvider)
          .when(
            data: (conversation) {
              if (conversation != null) {
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: conversation.length,

                  itemBuilder: (context, index) {
                    return ConversationTile(conversation: conversation[index]);
                  },
                );
              }
              return const Center(child: ReusableText("Start new chat"));
            },
            error: (error, stack) {
              return ErrorScreen(error.toString());
            },
            loading: () {
              return const Loader(color: AppColor.white);
            },
          ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: AppColor.blueSecondary,
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
