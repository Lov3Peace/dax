import 'package:flutter_application_1/responsive/desktop/util/ui/ProjectFeedPost.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class FeedSocketIoProvider extends ChangeNotifier {
  List projectFeed = [];
  List updatedFeed = [];
  bool showNewPostTextBox = false;

//
// Join Room for Project
  void joinProjectRoom(pid) {
    SocketIoClient.socket.emit("joinProjectRoom", pid);
    SocketIoClient.socket.on("roomJoined", (_) {
      logger.i("Room Joined Successfully");
    });
  }

  void enableFeed() {
    //
    // Register Listener for Getting the Feed from Server
    SocketIoClient.socket.on("feedResponse", (feed) {
      projectFeed.clear();
      // logger.e("Feed Response Received: $feed");
      for (int i = 0; i < feed.length; i++) {
        projectFeed.add(ProjectFeedPost(
          username: feed[i]["username"],
          timestamp: feed[i]["timestamp"].toString(),
          content: feed[i]["content"]["text"],
        ));
      }
      notifyListeners();
    });
    //
    // Register Listener for Getting a New Project Feed Post from Server (after someone posted)
    SocketIoClient.socket.on("feedUpdate", (update) {
      // logger.i("Feed Update Received: $update");
      projectFeed = [
        ProjectFeedPost(
          username: update["username"],
          timestamp: update["timestamp"].toString(),
          content: update["content"]["text"],
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
    logger.i("Feed Socket Disabled");
  }
}
