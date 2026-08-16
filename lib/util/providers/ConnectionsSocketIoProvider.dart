import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class Connection {
  final int requestId;
  final String senderUsername;
  final String receiverUsername;
  final int status;
  final DateTime timestamp;

  Connection({
    required this.requestId,
    required this.senderUsername,
    required this.receiverUsername,
    required this.status,
    required this.timestamp,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      requestId: json["request_id"],
      senderUsername: json["sender_username"],
      receiverUsername: json["receiver_username"],
      status: json["status"],
      timestamp: DateTime.parse(json["timestamp"]),
    );
  }
}

class ConnectionProvider extends ChangeNotifier {
  List<Connection> pendingRequests = [];
  List<Connection> connections = [];

  //
  // Join User Room
  void joinUserRoom(String userId) {
    SocketIoClient.socket.emit(
      "joinUserRoom",
      userId,
    );

    SocketIoClient.socket.on("userRoomJoined", (_) {
      logger.i("User Room Joined Successfully");
    });
  }

  //
  // Enable Connection Socket Listeners
  void enableConnections() {
    logger.i("Connection Socket Enabled");
    logger.i("Socket ID: ${SocketIoClient.socket.id}");

    //
    // New Connection Request
    SocketIoClient.socket.on(
      "connectionRequestReceived",
      (data) {
        final request = Connection.fromJson(
          Map<String, dynamic>.from(data),
        );

        pendingRequests = [
          request,
          ...pendingRequests,
        ];

        notifyListeners();
      },
    );

    //
    // Connection Request Accepted
    SocketIoClient.socket.on(
      "connectionRequestAccepted",
      (data) {
        final connection = Connection.fromJson(
          Map<String, dynamic>.from(data),
        );

        pendingRequests.removeWhere(
          (request) => request.requestId == connection.requestId,
        );

        connections = [
          connection,
          ...connections,
        ];

        notifyListeners();
      },
    );

    //
    // Connection Request Rejected
    SocketIoClient.socket.on(
      "connectionRequestRejected",
      (data) {
        final connection = Connection.fromJson(
          Map<String, dynamic>.from(data),
        );

        pendingRequests.removeWhere(
          (request) => request.requestId == connection.requestId,
        );

        notifyListeners();
      },
    );

    //
    // Connection Removed
    SocketIoClient.socket.on(
      "connectionRemoved",
      (data) {
        connections.removeWhere(
          (connection) =>
              connection.requestId == data["connectionId"],
        );

        notifyListeners();
      },
    );
  }
}
