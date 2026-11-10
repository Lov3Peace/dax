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
  final bool online;
  final DateTime? lastSeen;

  Connection({
    required this.requestId,
    required this.senderUsername,
    required this.receiverUsername,
    required this.status,
    required this.timestamp,
    required this.online,
    required this.lastSeen,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      requestId: json["request_id"],
      senderUsername: json["sender_username"],
      receiverUsername: json["receiver_username"],
      status: json["status"],
      timestamp: DateTime.parse(json["timestamp"]),
      online: json['online'] ?? false,
      lastSeen:
          json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
    );
  }

  String get lastSeenDisplay {
    if (online) return "Now";

    if (lastSeen == null) return "Unknown";

    final difference = DateTime.now().difference(lastSeen!);

    if (difference.inMinutes < 1) return "Just now";
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    }
    if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    }
    if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    }

    return "${lastSeen!.toLocal().month}/${lastSeen!.toLocal().day}/${lastSeen!.toLocal().year}";
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
    logger.i(
      "SOCKET CHECK: connected=${SocketIoClient.socket.connected}, "
      "id=${SocketIoClient.socket.id}",
    );
    // Join User Room
    // SocketIoClient.socket.emit(
    //   "joinUserRoom",
    //   username,
    // );
    final socket = SocketIoClient.socket;

    socket.off("currentConnectionRequests");
    socket.off("connectionRequestSent");
    socket.off("connectionRequestError");
    socket.off("connectionRequestReceived");
    socket.off("connectionRequestAccepted");
    socket.off("connectionRequestRejected");
    socket.off("connectionRemoved");
    socket.off("connections");
    socket.off("userRoomJoined");

    void joinRoom() {
      socket.emit("joinUserRoom", username);
      socket.emit("getConnectionRequests", username);
      socket.emit("getConnections", username);
    }

    if (socket.connected) {
      joinRoom();
    } else {
      socket.once("connect", (_) {
        joinRoom();
      });

      socket.connect();
    }

    SocketIoClient.socket.on("userRoomJoined", (_) {
      logger.i("User Room Joined Successfully");
    }); //

    // Existing Connection Requests
    SocketIoClient.socket.on(
      "currentConnectionRequests",
      (data) {
        print(data);
        pendingRequests = (data[0] as List)
            .map(
              (request) => Connection.fromJson(Map.from(request)),
            )
            .toList();

        notifyListeners();
      },
    );

    // Connection Request Sent
    SocketIoClient.socket.on("connectionRequestSent", (_) {
      logger.w("Event: connectionRequestSent");
      showPopupMessage(
          "Connection Request Sent!", navigatorKey.currentState?.context);
    });

    // Connection Request error
    SocketIoClient.socket.on("connectionRequestError", (_) {
      showPopupMessage(
          "Unable to Complete Request!", navigatorKey.currentState?.context);
    });

    // Current Connections
    SocketIoClient.socket.on(
      "connections",
      (data) {
        final records = data is List && data.isNotEmpty && data.first is List
            ? data.first as List
            : data as List;

        connections = records
            .whereType<Map>()
            .map(
              (item) => Connection.fromJson(
                Map<String, dynamic>.from(item),
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
        final request = Connection.fromJson(
          Map<String, dynamic>.from(data[0]),
        );

        if (!pendingRequests.any(
          (existing) => existing.requestId == request.requestId,
        )) {
          pendingRequests.insert(0, request);
        }
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

    // Online / Offline Status
    SocketIoClient.socket.off("userPresenceChanged");

    SocketIoClient.socket.on("userPresenceChanged", (data) {
      logger.i("Presence changed: $data");

      SocketIoClient.socket.emit("getConnections", username);
    });

    // Connection Request Accepted
    SocketIoClient.socket.on(
      "connectionRequestAccepted",
      (data) {
        final connection = Connection.fromJson(
          Map<String, dynamic>.from(data[0]),
        );

        final context = navigatorKey.currentState?.overlay?.context;
        if (context == null) return;
        if (!connections.any(
          (existing) => existing.requestId == connection.requestId,
        )) {
          pendingRequests.removeWhere(
            (request) => request.requestId == connection.requestId,
          );
          connections.insert(0, connection);
          showNotificationPopup(
              context,
              NotificationPopup(
                  notificationHeader: "New Connection",
                  notificationText: connection.receiverUsername,
                  width: 15.w(context),
                  height: 8.w(context),
                  icon: const Icon(Icons.person)));
        }
        notifyListeners();

        SocketIoClient.socket.emit("getConnections", username);
      },
    );

    // Connection Request Rejected
    SocketIoClient.socket.on(
      "connectionRequestRejected",
      (data) {
        final connection = Connection.fromJson(
          Map<String, dynamic>.from(data[0]),
        );

        pendingRequests.removeWhere(
          (request) => request.requestId == connection.requestId,
        );

        notifyListeners();

        // Fetch the latest connections from PostgreSQL
        SocketIoClient.socket.emit("getConnections", username);
      },
    );

    // Connection Removed
    SocketIoClient.socket.on(
      "connectionRemoved",
      (data) {
        final requestId = data[0]["requestId"].toString();

        connections.removeWhere(
          (connection) => connection.requestId == requestId,
        );
        notifyListeners();
      },
    );
    SocketIoClient.socket.off("refreshConnections");

    SocketIoClient.socket.on("refreshConnections", (_) {
      SocketIoClient.socket.emit("getConnections", username);
    });
  }

  // Save List of Users from Add Connection Search Box
  saveUserList(connectionRequestList) {
    this.connectionRequestList = connectionRequestList;
    notifyListeners();
  }

  void removeConnection(String requestId) {
    SocketIoClient.socket.emit(
      "removeConnection",
      {"requestId": requestId},
    );
  }
}
