import 'package:flutter_application_1/util/imports.dart';
import '../../../../../util/ui/gradient_label.dart';
import '../../../../../util/ui/tactile_button.dart';

class ConnectionTactile extends StatefulWidget {
  // Callback used to notify the parent which tab was selected
  final Function(int) onButtonTap;

  const ConnectionTactile({
    super.key,
    required this.onButtonTap,
  });

  @override
  State<ConnectionTactile> createState() => ConnectionTactileState();
}

class ConnectionTactileState extends State<ConnectionTactile> {
  // Tracks which button is visually active inside this widget
  // Defaults to the first tab ("All") on initial load
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Labels for each connection filter tab
    final List<String> buttonLabels = ['All', 'Favorite', 'Partner'];

    return Row(
      // Evenly distributes the filter buttons across the container
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttonLabels.length, (index) {
        // Determines whether the current button should display
        // its active / highlighted styling
        final bool isSelected = selectedIndex == index;

        return TactileButton(
          onTap: () {
            // Updates the local selected state for button styling
            setState(() => selectedIndex = index);

            // Notifies the parent so linked content can change
            widget.onButtonTap(index);
          },
          child: GradientContainer(
            // Applies the active gradient only to the selected tab
            gradient1: isSelected ? red : Colors.transparent,
            gradient2: isSelected ? purp : Colors.transparent,
            height: 3.h(context),
            width: 7.w(context),
            neonGlow: tran,
            text: buttonLabels[index],
            textSize: 2.5.sp(context),
            borderColor: Colors.white38,
            borderRadius: 500,
          ),
        );
      }),
    );
  }
}
