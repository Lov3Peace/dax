import 'package:flutter_application_1/util/PopupDialog.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';
import 'package:flutter_application_1/util/NotificationPopup.dart';

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

    // Current Connections
    SocketIoClient.socket.on(
      "connections",
      (data) {
        logger.i("Event: currentConnections\n$data");
        // connections = (data as List)
        //     .map(
        //       (connection) => Connection.fromJson(
        //         (Map.from(connection)),
        //       ),
        //     )
        //     .toList();
        //
        notifyListeners();
      },
    );

// Connection Request Sent
    SocketIoClient.socket.on("connectionRequestSent", (_) {
      logger.w("Event: connectionRequestSent");
      showPopupMessage(
          "Connection Request Sent!", navigatorKey.currentState?.context);
      print("Sent!");
    });

// Connection Request error
    SocketIoClient.socket.on("connectionRequestError", (_) {
      showPopupMessage(
          "Unable to Complete Request!", navigatorKey.currentState?.context);
    });

    // Connection Request Received
    SocketIoClient.socket.on(
      "connectionRequestReceived",
      (data) {
        logger.i("Event: connectionRequestReceived");
        logger.i("Data: $data");
        final reqObjType = data[0].runtimeType;
        logger.i("Data[0] Type: $reqObjType");
        final request = Connection.fromJson(
          Map<String, dynamic>.from(data[0]),
        );
        final senderUsername = request.senderUsername;
        logger.i("Sender Username: $senderUsername");

        final reqType = request.runtimeType;
        logger.i("Request Type: $reqType");
        // dev.debugger();
        pendingRequests = [
          request,
          ...pendingRequests,
        ];
        final context = navigatorKey.currentState?.overlay?.context;
        if (context == null) return;
        showNotificationPopup(
          context,
          NotificationPopup(
              onAccept: () {
                if (!SocketIoClient.socket.connected) {
                  logger.e("Accept failed: socket not connected");
                  return;
                }
                SocketIoClient.socket.emit(
                  "acceptConnection",
                  {
                    "requestId": request.requestId,
                    "username": request.receiverUsername,
                  },
                );
                closeNoticiationPopup();
                logger.i("Connection Request Accepted");
              },
              onReject: () {
                if (!SocketIoClient.socket.connected) {
                  logger.e("Reject failed: socket not connected");
                  return;
                }
                SocketIoClient.socket.emit(
                  "rejectConnection",
                  {
                    "requestId": request.requestId,
                    "username": request.receiverUsername,
                  },
                );
                closeNoticiationPopup();
                logger.i("Connection Request Rejected");
              },
              notificationHeader: "Connection Request Received",
              notificationText: data[0]["sender_username"],
              width: 15.w(context),
              height: 8.w(context),
              icon: const Icon(Icons.person)),
        );
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
        // _pendingRequests.removeWhere(
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
        final connection = Connection.fromJson(
          Map<String, dynamic>.from(data[0]),
        );

        // dev.debugger();
        pendingRequests.removeWhere(
          (request) => request.requestId == connection.requestId,
        );

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
