import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:ionicons/ionicons.dart';

class ActionsButtons extends StatelessWidget {
  final String requestId;

  final void Function(String) onRemoveConnection;
  const ActionsButtons({
    super.key,
    required this.requestId,
    required this.onRemoveConnection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Primary action: opens chat / messaging interaction
        TactileButton(
          scale: 1.05,
          child: Container(
            height: 3.5.h(context),
            width: 4.h(context),

            // Gradient styling to highlight this as the main action
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(1.5.w(context)),
              ),
              gradient: LinearGradient(
                colors: [purp, Colors.purple.shade300],
              ),
            ),

            child: Icon(
              Ionicons.chatbubble_sharp,
              size: 2.h(context),
            ),
          ),
        ),

        // Spacing between action buttons
        SizedBox(width: .5.h(context)),

        // Secondary action: opens additional options (menu / settings)

        PopupMenuButton<String>(
          tooltip: "",
          offset: const Offset(0, 35),
          color: const Color(0xFF1E1E2A),
          onSelected: (value) {
            if (value == "remove") {
              onRemoveConnection(requestId);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: "remove",
              child: Row(
                children: [
                  Icon(
                    Icons.person_remove_outlined,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text("Remove Connection"),
                ],
              ),
            ),
          ],
          child: TactileButton(
            scale: 1.05,
            child: Container(
              height: 3.5.h(context),
              width: 4.h(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(1.5.w(context)),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade800,
                    Colors.grey.shade700,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Ionicons.ellipsis_horizontal,
                  size: 2.h(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //
        // Accept Connection Request
        TactileButton(
          scale: 1.05,
          onTap: onAccept,
          child: Container(
            height: 3.5.h(context),
            width: 4.h(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(1.5.w(context)),
              ),
              gradient: const LinearGradient(
                colors: [purp, pink],
              ),
            ),
            child: Icon(
              Ionicons.checkmark,
              size: 2.h(context),
            ),
          ),
        ),

        SizedBox(width: .5.h(context)),

        //
        // Reject Connection Request
        TactileButton(
          scale: 1.05,
          onTap: onReject,
          child: Container(
            height: 3.5.h(context),
            width: 4.h(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(1.5.w(context)),
              ),
              gradient: LinearGradient(
                colors: [orange, red],
              ),
            ),
            child: Icon(
              Ionicons.close,
              size: 2.h(context),
            ),
          ),
        ),
      ],
    );
  }
}
