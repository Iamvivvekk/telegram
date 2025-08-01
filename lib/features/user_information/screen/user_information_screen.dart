import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/image_picker.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/features/user_information/controller/user_info_controller.dart';
import 'package:telegram/providers/user_data_provider.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? file;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void submitAdditionalInfo() {
    ref
        .read(userInfoControllerProvider.notifier)
        .addAdditionalInfo(_nameController.text.trim(), file, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeightSpacer(height: 40),
                  GestureDetector(
                    onTap: () async {
                      file = await pickImage();
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.darkGrey,
                              backgroundImage: file == null
                                  ? ref.watch(userDataProvider)?.profilePic ==
                                            null
                                        ? const AssetImage(
                                            "assets/images/profile_default.png",
                                          )
                                        : CachedNetworkImageProvider(
                                            ref
                                                .watch(userDataProvider)!
                                                .profilePic!,
                                          )
                                  : FileImage(file!),
                            );
                          },
                        ),
                        const Positioned(
                          bottom: 10,
                          right: 5,
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                  const HeightSpacer(height: 40),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Your Name",
                      // labelText: "Name",
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const Spacer(flex: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      final isLoading = ref.watch(userInfoControllerProvider);
                      return CustomButton(
                        onTap: isLoading ? null : submitAdditionalInfo,
                        text: "Save",
                        child: isLoading ? const Loader() : null,
                      );
                    },
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
