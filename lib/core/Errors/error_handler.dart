import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {
  ErrorHandler._();
  static String call(dynamic e) {
    try {
      if (e is FirebaseAuthException) {
        throw "${e.message}";
      } else if (e is FirebaseException) {
        throw "${e.message}";
      } else if (e is SocketException) {
        throw "🔌 No internet connection or host unreachable";
      } else if (e is HttpException) {
        throw e.message;
      } else if (e is FormatException) {
        throw e.message;
      } else if (e is HttpException) {
        throw "❌ HTTP error: ${e.message}";
      } else if (e is TimeoutException) {
        throw "⏰ Request timed out";
      } else {
        throw e;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
