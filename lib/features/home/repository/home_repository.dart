import 'package:dio/dio.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(Dio dio) : _dio = dio;

  // FutureEither<UserModel> getUser(String uid) async {
  //   try {
  //     if (uid.isEmpty) {
  //       return left(Failure("Not logged id"));
  //     }
  //     final response = await _dio.get("");
  //   } catch (e) {}
  // }
}
