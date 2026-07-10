import "package:flutter/services.dart";
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

final FocusNode textFieldFocusNode = FocusNode();
final FocusNode keyboardListenerFocusNode = FocusNode();

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
                  textFieldFocusNode.requestFocus();
                  _projectFeedPostController.clear();
                },
                scale: 1.04,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: max(10, 2.w(context)),
                  vertical: max(5, 0.5.w(context)),
                ),
                borderRadius: 10.w(context),
                borderColor: darkGrey,
                child: Text(
                  feedSocketIoProvider.showNewPostTextBox
                      ? "Cancel"
                      : "New Post",
                  style: TextStyle(
                    fontSize: max(12, 2.sp(context)),
                    color: white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: max(5, 0.5.w(context)),
          ),
          NewProjectFeedPostTextfield(),
          Expanded(
            child: StaggerLoad(
                scale: 1.01,
                duration: 300,
                childPadding: EdgeInsets.only(bottom: max(5, 0.5.w(context))),
                widgets: feedSocketIoProvider.projectFeed,
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final feedSocketIoProvider = context.watch<FeedSocketIoProvider>();
    return Visibility(
        visible: feedSocketIoProvider.showNewPostTextBox,
        child: Column(
          children: [
            SizedBox(height: max(5, 0.5.w(context))),
            Focus(
              focusNode: keyboardListenerFocusNode,
              onKeyEvent: (node, event) {
                // only submit on enter if SHIFT is not held down and the
                // content is not empty
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.enter &&
                    !HardwareKeyboard.instance.isShiftPressed &&
                    _projectFeedPostController.text.trim().isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  post();
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: TextField(
                focusNode: textFieldFocusNode,
                autofocus: true,
                maxLines: 3,
                minLines: 1,
                cursorColor: red,
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
            ),
            SizedBox(height: max(5, 1.w(context))),
            Align(
              alignment: Alignment.bottomRight,
              child: PillButton(
                  onTap: () {
                    // Post If Textfield is Not Empty
                    if (_projectFeedPostController.text != "") {
                      setState(() {
                        isLoading = true;
                      });
                      post();
                    }
                  },
                  isLoading: isLoading,
                  scale: 1.03,
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.5.w(context), vertical: 0.5.w(context)),
                  color1: pink,
                  color2: red,
                  borderRadius: 20.w(context),
                  borderColor: tran,
                  child: Text(
                    "Post",
                    style: TextStyle(
                      fontSize: max(12, 2.sp(context)),
                      color: white,
                    ),
                  )),
            ),
          ],
        ).animate().fadeIn(duration: Duration(milliseconds: 300)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void post() {
    final feedSocketIoProvider = context.read<FeedSocketIoProvider>();
    logger.i("Emitting createProjectFeedPost...");
    SocketIoClient.socket.timeout(5000).emitWithAck("createProjectFeedPost", {
      "pid": 1,
      "username": username,
      "content": {"text": _projectFeedPostController.text},
      "event_type": 1
    }, ack: (err) {
      if (err != null) {
        logger.e(err);
        showDialog(
            barrierLabel: "errorPosting",
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return Center(
                child: BlurryContainer(
                    height: 5.w(context),
                    width: 25.w(context),
                    padding: EdgeInsets.all(1.w(context)),
                    child: Center(
                        child: Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: red,
                        ),
                        SizedBox(
                          width: 1.w(context),
                        ),
                        const Text(
                            "Unable to Submit Post. Server Might be Down"),
                      ],
                    ))),
              );
            });
      }
      setState(() {
        isLoading = false;
      });
      feedSocketIoProvider.toggleNewPostTextBox();
    });
    // Hide Textfield After
  }
}
