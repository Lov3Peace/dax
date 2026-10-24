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
      required this.icon,
      this.onAccept,
      this.onDecline});

  final String notificationText;
  final String notificationHeader;
  final Icon icon;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlurryContainer(
            width: 15.w(context),
            height: 5.w(context),
            padding: EdgeInsets.all(1.w(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationHeader,
                  style: TextStyle(fontSize: max(12, 2.5.sp(context))),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    icon,
                    Expanded(
                      child: Text(
                        notificationText,
                        style: TextStyle(
                            fontSize: max(12, 2.5.sp(context)),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
                if (onAccept != null || onDecline != null)
                  Padding(
                    padding: EdgeInsets.only(top: 1.w(context)),
                    child: Row(
                      children: [
                        if (onAccept != null)
                          Expanded(
                            child: TactileButton(
                              onTap: onAccept,
                              child: Container(
                                padding: EdgeInsets.all(0.5.w(context)),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Center(child: Text('Accept')),
                              ),
                            ),
                          ),
                        if (onDecline != null)
                          Expanded(
                            child: TactileButton(
                              onTap: onDecline,
                              child: Container(
                                padding: EdgeInsets.all(0.5.w(context)),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Center(child: Text('Decline')),
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
        Positioned(
          right: 0,
          child: TactileButton(
            onTap: () => closeNoticiationPopup(),
            child: Container(
                padding: EdgeInsets.all(0.5.w(context)),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: orangeGlow,
                ),
                child: Icon(
                  Icons.close,
                  size: 1.w(context),
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
