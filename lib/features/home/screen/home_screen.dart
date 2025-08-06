import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/features/drawer/presentation/screen/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {}

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: 0, //conversation.length,
        itemBuilder: (context, index) {
          return index < 0
              ? const Center(child: Text("No conversation yet,\nStart new"))
              : const Center(
                  child: Text("No conversation yet,\nStart new"),
                ); // ConversationTile(conversation: conversation[index]);
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
