import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/Errors/error_handler.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/model/user_model.dart';

final userInfoRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioServiceProvider);
  return UserInformationRepository(auth: FirebaseAuth.instance, dio: dio);
});

class UserInformationRepository {
  final Dio _dio;
  final FirebaseAuth auth;

  UserInformationRepository({required Dio dio, required this.auth})
    : _dio = dio;
  FutureEither<UserModel> addUserInfo(String fullName, File? profile) async {
    try {
      FormData formdata;
      if (auth.currentUser?.uid == null) {
        return throw "Unauthorized";
      }
      if (profile != null && profile.path.isNotEmpty) {
        formdata = FormData.fromMap({
          "fullName": fullName,
          "profile": await MultipartFile.fromFile(profile.path),
        });
        log("profile is with profile");
      } else {
        log("profile is withoutprofile");
        formdata = FormData.fromMap({"fullName": fullName});
      }

      final response = await _dio.post(
        ApiConstants.additionalInfo,
        data: formdata,
        options: Options(
          headers: {"authorization": auth.currentUser!.uid},
          contentType: "multipart/form-data",
        ),
      );
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        return right(user);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }
}
