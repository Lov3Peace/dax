import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class Connection {
  final String requestId;
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

class ConnectionsProvider extends ChangeNotifier {
  List<Connection> pendingRequests = [];
  List<Connection> connections = [];
  List<String> connectionRequestList = [];

  // Enable Connection Socket Listeners
  void enableConnections(String username) {
    logger.i("Connection Socket Enabled");
    logger.i("Username: $username");
    logger.i("Socket ID: ${SocketIoClient.socket.id}");

    // Join User Room
    SocketIoClient.socket.emit(
      "joinUserRoom",
      username,
    );

    SocketIoClient.socket.on("userRoomJoined", (_) {
      logger.i("User Room Joined Successfully");
    }); //

    // Existing Connection Requests
    SocketIoClient.socket.on(
      "currentConnectionRequests",
      (data) {
        logger.i("Event: currentConnectionRequests");
        print(data);
        pendingRequests = (data[0] as List)
            .map(
              (request) => Connection.fromJson(Map.from(request)),
            )
            .toList();

        notifyListeners();
      },
    );

    // Existing Accepted Connections
    SocketIoClient.socket.on(
      "connections",
      (data) {
        logger.i("Event: connections");
        connections = (data as List)
            .map(
              (connection) => Connection.fromJson(
                (Map.from(connection)),
              ),
            )
            .toList();

        notifyListeners();
      },
    );

    // New Connection Requests
    SocketIoClient.socket.on(
      "connectionRequestReceived",
      (data) {
        logger.i("Event: connectionRequestReceived");
        // final request = Connection.fromJson(
        //   Map<String, dynamic>.from(data),
        // );
        //
        // pendingRequests = [
        //   request,
        //   ...pendingRequests,
        // ];

        notifyListeners();
      },
    );

    // Connection Request Accepted
    SocketIoClient.socket.on(
      "connectionRequestAccepted",
      (data) {
        logger.i("Event: connectionRequestAccepted");
        // final connection = Connection.fromJson(
        //   Map<String, dynamic>.from(data),
        // );
        //
        // pendingRequests.removeWhere(
        //   (request) => request.requestId == connection.requestId,
        // );
        //
        // connections = [
        //   connection,
        //   ...connections,
        // ];

        notifyListeners();
      },
    );

    // Connection Request Rejected
    SocketIoClient.socket.on(
      "connectionRequestRejected",
      (data) {
        logger.i("Event: connectionRequestRejected");
        // final connection = Connection.fromJson(
        //   Map<String, dynamic>.from(data),
        // );
        //
        // pendingRequests.removeWhere(
        //   (request) => request.requestId == connection.requestId,
        // );

        notifyListeners();
      },
    );

    // Connection Removed
    SocketIoClient.socket.on(
      "connectionRemoved",
      (data) {
        logger.i("Event: connectionRemoved");
        // connections.removeWhere(
        //   (connection) => connection.requestId == data["connectionId"],
        // );

        notifyListeners();
      },
    );
    // Load Existing Pending Requests
    SocketIoClient.socket.emit(
      "getConnectionRequests",
      username,
    );
    SocketIoClient.socket.emit(
      "getConnections",
      username,
    );
  }

  // Save List of Users from Add Connection Search Box
  saveUserList(connectionRequestList) {
    this.connectionRequestList = connectionRequestList;
    notifyListeners();
  }
}
