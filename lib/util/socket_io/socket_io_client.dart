import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class SocketIoClient {
// Cretae socket instance to use throughout application
  static final IO.Socket socket = IO.io(
      hostname,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());
}
