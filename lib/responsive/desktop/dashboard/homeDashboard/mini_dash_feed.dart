import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/responsive/desktop/util/stagger_load.dart";
import "package:flutter_application_1/responsive/desktop/util/ui/ProjectFeedPost.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/logger/CarbonLogger.dart";
import "package:flutter_application_1/util/providers/FeedSocketIoProvider.dart";
import "package:flutter_application_1/util/providers/userProvider.dart";
import "package:flutter_application_1/util/socket_io/socket_io_client.dart";
import "package:flutter_application_1/util/ui/pillButton.dart";
import "package:provider/provider.dart";

final TextEditingController _projectFeedPostController =
    TextEditingController();

class MiniProjectDashFeed extends StatefulWidget {
  const MiniProjectDashFeed({super.key});

  @override
  State<MiniProjectDashFeed> createState() => _MiniProjectDashFeedState();
}

late UserProvider userProvider;
String username = "";

class _MiniProjectDashFeedState extends State<MiniProjectDashFeed> {
  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    username = userProvider.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watching the projectFeed Value in FeedSocketIoProvider and Updating on Change
    final feedSocketIoProvider = context.watch<FeedSocketIoProvider>();

    return BlurryContainer(
      // constraints: BoxConstraints(minWidth: 100, minHeight: 100),
      padding: EdgeInsets.all(max(5, 1.w(context))),
      color: tran,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Feed",
                style: TextStyle(
                  fontSize: max(16, 4.sp(context)),
                  fontWeight: FontWeight.bold,
                  color: grey,
                ),
              ),
              PillButton(
                onTap: () {
                  feedSocketIoProvider.toggleNewPostTextBox();
                  _projectFeedPostController.clear();
                },
                scale: 1.04,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: max(10, 2.w(context)),
                  vertical: max(5, 0.5.w(context)),
                ),
                textColor: darkGrey,
                borderRadius: 10.w(context),
                borderColor: darkGrey,
                text: feedSocketIoProvider.showNewPostTextBox
                    ? "Cancel"
                    : "New Post",
                textSize: max(12, 2.sp(context)),
              )
            ],
          ),
          SizedBox(
            height: max(5, 0.5.w(context)),
          ),
          Expanded(
            child: StaggerLoad(
                duration: 300,
                childPadding: EdgeInsets.only(bottom: max(5, 0.5.w(context))),
                widgets: [
                  NewProjectFeedPostTextfield(),
                  ...feedSocketIoProvider.projectFeed
                ],
                scrollDirection: Axis.vertical,
                delay: 0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class NewProjectFeedPostTextfield extends StatefulWidget {
  const NewProjectFeedPostTextfield({super.key});

  @override
  State<NewProjectFeedPostTextfield> createState() =>
      _NewProjectFeedPostTextfieldState();
}

class _NewProjectFeedPostTextfieldState
    extends State<NewProjectFeedPostTextfield> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedSocketIoProvider = context.watch<FeedSocketIoProvider>();
    return Visibility(
        visible: feedSocketIoProvider.showNewPostTextBox,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              maxLines: 3,
              cursorColor: red,
              onSubmitted: (_) => post,
              style: TextStyle(fontSize: 3.sp(context)),
              controller: _projectFeedPostController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.5.w(context)),
                  borderSide: BorderSide(
                    color: deckBorderColor,
                    width: 0.05.w(context),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.w(context)),
                  borderSide: const BorderSide(color: white),
                ),
              ),
            ),
            SizedBox(height: max(5, 1.w(context))),
            Align(
              alignment: Alignment.bottomRight,
              child: PillButton(
                  onTap: () {
                    // Post If Textfield is Not Empty
                    if (_projectFeedPostController.text != "") {
                      post();
                    }
                  },
                  textSize: max(12, 2.sp(context)),
                  scale: 1.03,
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w(context), vertical: 0.5.w(context)),
                  color1: pink,
                  color2: red,
                  text: "Post",
                  textColor: white,
                  borderRadius: 20.w(context),
                  borderColor: tran),
            ),
          ],
        ).animate().fadeIn(duration: Duration(milliseconds: 300)));
  }

  @override
  void dispose() {
    // Turn Off Sockets After Leaving the Page (dont need them persistent)
    SocketIoClient.socket.off("feedResponse");
    SocketIoClient.socket.off("feedUpdate");
    logger.i("Project Dash Feed Disposed");
    super.dispose();
  }

  void post() {
    final feedSocketIoProvider = context.read<FeedSocketIoProvider>();
    logger.i("Emitting createProjectFeedPost...");
    SocketIoClient.socket.emit("createProjectFeedPost", {
      "pid": 1,
      "username": username,
      "content": {"text": _projectFeedPostController.text},
      "event_type": 1
    });
    // Hide Textfield After
    feedSocketIoProvider.toggleNewPostTextBox();
  }
}
