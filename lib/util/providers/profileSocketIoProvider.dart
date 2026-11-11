import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/socket_io/socket_io_client.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? profile;
  bool isLoading = false;
  String? error;

  void enableProfile() {
    SocketIoClient.socket.off("userProfileResponse");
    SocketIoClient.socket.off("userProfileError");

    SocketIoClient.socket.on("userProfileResponse", (data) {
      profile = Map<String, dynamic>.from(data[0]);
      isLoading = false;
      error = null;
      debugPrint("PROFILE LOADED: ${profile?['username']}");
      notifyListeners();
    });
    SocketIoClient.socket.on("userProfileError", (data) {
      debugPrint("PROFILE ERROR: $data");

      final dynamic errorData =
          data is List && data.isNotEmpty ? data.first : data;

      error = errorData is Map
          ? errorData["message"]?.toString() ?? "Could not load profile"
          : "Could not load profile";

      isLoading = false;
      notifyListeners();
    });
  }

// Request a specific user's profile
  void getUserProfile(String username) {
    profile = null;
    error = null;
    isLoading = true;
    notifyListeners();
    debugPrint("REQUESTING PROFILE: $username");
    debugPrint(
      "PROFILE SOCKET CONNECTED: ${SocketIoClient.socket.connected}",
    );
    SocketIoClient.socket.emit("getUserProfile", username);
  }
}
