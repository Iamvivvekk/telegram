import 'dart:async';

import 'package:telegram/model/message_model.dart';

class MessageStream {
  MessageStream._internal();

  static final MessageStream _instance = MessageStream._internal();

  factory MessageStream.instance() => _instance;

  final StreamController _messageStream = StreamController<Message>();

  void Function(Message) get addResponse => _messageStream.sink.add;

  Stream<Message> get getResponse => _messageStream.stream as Stream<Message>;

  void dispose() {
    _messageStream.close();
  }
}
