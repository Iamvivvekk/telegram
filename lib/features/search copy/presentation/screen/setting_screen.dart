import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/features/search%20copy/presentation/widget/section_tile.dart';
import 'package:telegram/features/search%20copy/presentation/widget/section_title.dart';
import 'package:telegram/features/search%20copy/presentation/widget/settings_header.dart';
import 'package:telegram/providers/user_data_provider.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const BackButton(),
        ),
        actions: const [
          Icon(Icons.qr_code, size: 22),
          SizedBox(width: 16),
          Icon(Icons.search, size: 22),
          SizedBox(width: 16),
          Icon(Icons.more_vert, size: 22),
          SizedBox(width: 10),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        controller: _scrollController,
        children: [
          const SettingHeader(),
          const SizedBox(height: 16),
          const SectionTitle(text: 'Account'),
          SectionTile(
            title: "${user?.mobile ?? ""}",
            subTitle: 'Tap to change phone number',
            onTap: () {},
          ),

          // TODO: add real data here
          SectionTile(title: "@iamvivvekk", subTitle: 'Username', onTap: () {}),
          SectionTile(
            title: 'Bio',
            subTitle: 'Add a few words about yourself',
            onTap: () {},
          ),
          const SizedBox(height: 12),

          const SectionTitle(text: 'Settings'),
          const SectionTile(icon: Icons.chat, title: "Chat Settings"),
          const SectionTile(icon: Icons.lock, title: "Privacy and Security"),
          const SectionTile(
            icon: Icons.notifications,
            title: "Notifications and Sounds",
          ),
          const SectionTile(icon: Icons.data_usage, title: "Data and Storage"),
          const SectionTile(icon: Icons.battery_saver, title: "Power Saving"),
          const SectionTile(icon: Icons.folder, title: "Chat Folders"),
          SectionTile(icon: Icons.devices, title: "Sign out", onTap: () {}),
        ],
      ),
    );
  }
}
