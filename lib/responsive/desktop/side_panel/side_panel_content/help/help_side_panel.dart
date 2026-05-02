import 'package:flutter_application_1/util/imports.dart';
import '../desk_dock_button_templates/toc_template.dart';

class FAQsSidePanel extends StatelessWidget {
  // Index of the currently selected FAQ section
  final int currentIndex;

  // Callback triggered when a table-of-contents item is tapped
  final Function(int) onTap;

  const FAQsSidePanel({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Transparent background so the parent styling shows through
      color: tran,
      width: 13.w(context),

      child: Column(
        // Align content toward the top-left of the side panel
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        // Keep the column only as tall as its children need
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header for the navigation section
          Text(
            'Table of Contents :',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 3.sp(context),
            ),
          ),

          // Space between the header and the list of navigation buttons
          SizedBox(height: 1.h(context)),

          // Reusable navigation widget that displays each FAQ category
          TableofContentsTemplate(
            currentIndex: currentIndex,
            onTap: onTap,

            // Labels shown in the FAQ navigation menu
            labels: const [
              'Questions',
              'Projects',
              'Communities',
              'Socials',
              'News',
              'Wallet',
              'Tips & Tricks',
            ],

            // Layout and sizing configuration for each navigation item
            spacing: 1.h(context),
            activeWidth: 13.w(context),
            inactiveWidth: 9.w(context),
            height: 4.h(context),
            fontSize: 2.sp(context),
          )
        ],
      ),
    );
  }
}
