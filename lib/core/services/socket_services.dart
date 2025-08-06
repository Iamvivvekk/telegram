import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/constants/shared_preferences_keys.dart';


class SocketServices {
  static final SocketServices _instance = SocketServices._internal();

  factory SocketServices() => _instance;

  late IO.Socket _socket;

  SocketServices._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(SharedPreferencesKeys.uid);
    _socket = IO.io(
      ApiConstants.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'userId': userId})
          .build(),
    );
    _socket.connect();
  }

  IO.Socket get socket => _socket;
}





// final socketProvider = AsyncNotifierProvider<SocketNotifier, IO.Socket>(
//   () => SocketNotifier(),
// );

// class SocketNotifier extends AsyncNotifier<IO.Socket> {
//   late IO.Socket _socket;

//   @override
//   Future<IO.Socket> build() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getString(SharedPreferencesKeys.uid);

//     _socket = IO.io(
//       ApiConstants.socketUrl,
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .setExtraHeaders({'userId': userId})
//           .build(),
//     );

//     _socket.connect();

//     _socket.onConnect((_) {
//       debugPrint("Socket connected: ${_socket.id}");
//     });

//     _socket.on("getOnlineUsers", (data) {
//       debugPrint("socket online users : $data");
//     });

//     _socket.onDisconnect((d) {
//       debugPrint("Socket disconnected: $d");
//     });

//     return _socket;
//   }

//   IO.Socket get instance => _socket;
// }