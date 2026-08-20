import 'package:flutter_application_1/responsive/desktop/util/ui/ProjectFeedPost.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class FeedSocketIoProvider extends ChangeNotifier {
  List<Widget> projectFeed = [];
  List updatedFeed = [];
  bool showNewPostTextBox = false;

//
// Join Room for Project
  void joinProjectRoom(pid) {
    SocketIoClient.socket.emit("joinProjectRoom", pid);
    SocketIoClient.socket.on("roomJoined", (_) {
      logger.i("Feed Room Joined Successfully");
    });
  }

  void enableFeed() {
    logger.i("Feed Socket Enabled");
    logger.i("Socket ID: ${SocketIoClient.socket.id}");
    //
    // Register Listener for Getting the Feed from Server
    SocketIoClient.socket.on("feedResponse", (feed) {
      projectFeed.clear();
      // logger.e("Feed Response Received: $feed");
      for (int i = 0; i < feed[0].length; i++) {
        projectFeed.add(ProjectFeedPost(
          username: feed[0][i]["username"],
          timestamp: feed[0][i]["display_timestamp"].toString(),
          content: feed[0][i]["content"]["text"],
        ));
      }
      notifyListeners();
    });
    //
    // Register Listener for Getting a New Project Feed Post from Server (after someone posted)
    SocketIoClient.socket.on("feedUpdate", (update) {
      logger.i("Feed Update Received: $update");
      projectFeed = [
        ProjectFeedPost(
          username: update[0]["username"],
          timestamp: update[0]["display_timestamp"].toString(),
          content: update[0]["content"]["text"],
        ),
        ...projectFeed
      ];
      notifyListeners();
    });
  }

  // Show/Hide the New Post Text Box
  void toggleNewPostTextBox() {
    showNewPostTextBox = !showNewPostTextBox;
    notifyListeners();
  }

  // Used on StatefulWidget Disposal
  void disableFeed() {
    SocketIoClient.socket.off("feedResponse");
    SocketIoClient.socket.off("feedUpdate");
    SocketIoClient.socket.off("roomJoined");
    logger.i("Feed Socket Disabled");
  }
}
