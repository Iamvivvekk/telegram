import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/image_picker.dart';
import 'package:telegram/features/user_information/controller/user_info_controller.dart';

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

  void pickProfileImage() async {
    file = await pickImage();
    if (file != null) {
      ref.read(userInfoProvider.notifier).updateImage(file!);
    }
  }

  void saveUserInfo() {
    if (_formKey.currentState!.validate()) {
      ref.watch(userInfoProvider);
    }
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
                    onTap: pickProfileImage,
                    child: Stack(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.darkGrey,
                              backgroundImage:
                                  ref.watch(userInfoProvider) != null
                                      ? FileImage(ref.read(userInfoProvider)!)
                                      : const AssetImage(
                                          "assets/images/profile_default.png"),
                            );
                          },
                        ),
                        const Positioned(
                          bottom: 10,
                          right: 5,
                          child: Icon(Icons.edit),
                        )
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
                  CustomButton(
                    onTap: saveUserInfo,
                    text: "Save",
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
