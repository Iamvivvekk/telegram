import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/providers/user_data_provider.dart';

class SettingHeader extends ConsumerWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    user?.profilePic != null && user!.profilePic!.isNotEmpty
                    ? CachedNetworkImageProvider(user.profilePic!)
                    : const AssetImage(ImageConstants.profileDefault),
              ),
              const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue,
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Vivek',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Text(
            'online',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
