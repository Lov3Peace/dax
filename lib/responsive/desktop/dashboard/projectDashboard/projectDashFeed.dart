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
bool showNewPostTextBox = false;

class ProjectDashFeed extends StatefulWidget {
  const ProjectDashFeed({super.key});

  @override
  State<ProjectDashFeed> createState() => _ProjectDashFeedState();
}

late UserProvider userProvider;
String username = "";

class _ProjectDashFeedState extends State<ProjectDashFeed> {
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
    List feed = feedSocketIoProvider.projectFeed;

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
                  setState(() {
                    showNewPostTextBox = !showNewPostTextBox;
                    _projectFeedPostController.clear();
                  });
                },
                scale: 1.04,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: max(10, 2.w(context)),
                  vertical: max(5, 0.5.w(context)),
                ),
                color: tran,
                textColor: darkGrey,
                borderRadius: 10.w(context),
                borderColor: darkGrey,
                text: showNewPostTextBox ? "Cancel" : "New Post",
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
                widgets: [NewProjectFeedPostTextfield(), ...feed],
                scrollDirection: Axis.vertical,
                delay: 75),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class NewProjectFeedPostTextfield extends StatelessWidget {
  const NewProjectFeedPostTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: showNewPostTextBox,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              maxLines: 3,
              cursorColor: red,
              // onSubmitted: ,
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
                    SocketIoClient.socket.emit("createProjectFeedPost", {
                      "pid": 1,
                      "username": username,
                      "content": {"text": _projectFeedPostController.text},
                      "event_type": 1
                    });
                    showNewPostTextBox = false;
                  },
                  textSize: max(12, 2.sp(context)),
                  scale: 1.03,
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w(context), vertical: 0.5.w(context)),
                  color: red,
                  text: "Post",
                  textColor: white,
                  borderRadius: 20.w(context),
                  borderColor: tran),
            ),
          ],
        ).animate().fadeIn(duration: Duration(milliseconds: 300)));
  }
}
