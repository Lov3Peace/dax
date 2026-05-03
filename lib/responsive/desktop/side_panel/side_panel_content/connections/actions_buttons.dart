import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:ionicons/ionicons.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Primary action: opens chat / messaging interaction
        TactileButton(
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
        TactileButton(
          child: Container(
            height: 3.5.h(context),
            width: 4.h(context),

            // Neutral styling to indicate lower priority action
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
      ],
    );
  }
}
