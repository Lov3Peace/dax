import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

final _overlay = navigatorKey.currentState?.overlay;
OverlayEntry? overlayEntry;

class NotificationPopup extends StatelessWidget {
  const NotificationPopup(
      {super.key,
      required this.notificationHeader,
      required this.notificationText,
      required this.width,
      required this.height,
      required this.icon,
      this.onAccept,
      this.onReject});

  final String notificationText;
  final String notificationHeader;
  final double width;
  final double height;
  final Icon icon;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(0.5.w(context)),
          child: BlurryContainer(
            width: width,
            height: height,
            padding: EdgeInsets.all(1.w(context)),
            borderRadius: 1.w(context),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Header
                Expanded(
                  flex: 1,
                  child: Text(
                    notificationHeader,
                    style: TextStyle(
                        fontSize: max(12, 2.5.sp(context)),
                        fontWeight: FontWeight.bold,
                        height: 1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //
                // Notification Text
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      icon,
                      SizedBox(width: 0.5.w(context)),
                      Expanded(
                        child: Text(
                          notificationText,
                          style: TextStyle(
                              fontSize: max(12, 3.sp(context)),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                // Accept + Reject
                if (onAccept != null || onReject != null)
                  Expanded(
                    flex: 2,
                    child: Row(
                      spacing: 1.w(context),
                      children: [
                        Expanded(
                          child: TactileButton(
                            onTap: onAccept,
                            child: Container(
                              padding: EdgeInsets.all(0.25.w(context)),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [purp, pink]),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.w(context))),
                              ),
                              child: Center(
                                  child: Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: max(12, 2.sp(context)),
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TactileButton(
                            onTap: onReject,
                            child: Container(
                              padding: EdgeInsets.all(0.25.w(context)),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [orange, red]),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.w(context))),
                              ),
                              child: Center(
                                  child: Text(
                                'Reject',
                                style: TextStyle(
                                    fontSize: max(12, 2.sp(context)),
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        //
        // Close Button
        Positioned(
          right: 0,
          child: TactileButton(
            onTap: () => closeNoticiationPopup(),
            child: Container(
                padding: EdgeInsets.all(0.5.w(context)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkGrey,
                ),
                child: Icon(
                  Icons.close,
                  size: 0.75.w(context),
                )),
          ),
        ),
      ],
    );
  }
}

void closeNoticiationPopup() {
  overlayEntry?.remove();
  overlayEntry?.dispose();
  overlayEntry = null;
}

void showNotificationPopup(BuildContext context, Widget widget) {
  if (_overlay == null) return;
  overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
          top: 20,
          right: 20,
          child: Material(
            type: MaterialType.transparency,
            child: widget.animate().slideX(
                duration: 350.milliseconds,
                begin: 1,
                end: 0,
                curve: Curves.easeOutBack),
          )));
  _overlay?.insert(overlayEntry!);
}
