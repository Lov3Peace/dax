import 'package:flutter_application_1/responsive/desktop/util/ui/ProjectFeedPost.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

class FeedSocketIoProvider extends ChangeNotifier {
  List projectFeed = [];

  void enableFeed() {
    SocketIoClient.socket.on("feedResponse", (feed) {
      for (int i = 0; i < feed.length; i++) {
        logger.e(feed);
        projectFeed.add(ProjectFeedPost(
          user_id: feed[i]["user_id"],
          timestamp: feed[i]["timestamp"].toString(),
          content: feed[i]["content"]["text"],
        ));
      }
      notifyListeners();
    });
    SocketIoClient.socket.on("feedUpdate", (update) {
      projectFeed.add(ProjectFeedPost(
        user_id: update["user_id"],
        timestamp: update["timestamp"].toString(),
        content: update["content"]["text"],
      ));
      notifyListeners();
    });
  }

  // Used on StatefulWidget Disposal
  void disableFeed() {
    SocketIoClient.socket.off("feedResponse");
    logger.i("Feed Socket Disabled");
  }
}
