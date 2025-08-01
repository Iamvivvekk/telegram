import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/constants/shared_preferences_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketProvider = AsyncNotifierProvider<SocketNotifier, io.Socket>(
  SocketNotifier.new,
);

class SocketNotifier extends AsyncNotifier<io.Socket> {
  late io.Socket _socket;

  @override
  Future<io.Socket> build() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(SharedPreferencesKeys.uid);

    _socket = io.io(
      ApiConstants.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'userId': userId})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint("Socket connected: ${_socket.id}");
    });

    _socket.onDisconnect((_) {
      debugPrint("Socket disconnected: ${_socket.id}");
    });

    return _socket;
  }

  io.Socket get instance => _socket;
}


