import 'package:socket_io_client/socket_io_client.dart';

class HomeSocketRepository {
  final Socket _socket;

  HomeSocketRepository(Socket socket) : _socket = socket;

  List<String> getOnlineStatus() {
    List<String> users = [];
    _socket.on("getOnlineUsers", (user) {
      final data = user as List<String>;
      users.addAll(data);
    });
    print(users);
    return users;
  }
}
