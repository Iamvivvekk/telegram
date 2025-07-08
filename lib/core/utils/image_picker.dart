import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final picker = ImagePicker();
  File? image;
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    image = File(pickedImage.path);
  }
  // log(image != null ? image.path : "");
  return image;
}
