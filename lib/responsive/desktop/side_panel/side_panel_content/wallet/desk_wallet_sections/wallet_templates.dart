import 'package:flutter_application_1/util/imports.dart';
import '../../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

/// A custom dropdown field that displays a list of linked cards
/// using an Overlay instead of a traditional DropdownButton.
///
/// Why Overlay?
/// - Allows full control over positioning, styling, and animations
/// - Avoids layout constraints inside parent widgets
/// - Mimics native "floating dropdown" behavior
class LinkedCardDropdownField extends StatefulWidget {
  final List<String> cards; // List of selectable card names
  final TextEditingController controller; // Controls displayed selected value
  final String label; // Input label text
  final double? height;
  final double? width;

  const LinkedCardDropdownField({
    super.key,
    required this.cards,
    required this.controller,
    this.label = '',
    this.height,
    this.width,
  });

  @override
  State<LinkedCardDropdownField> createState() =>
      LinkedCardDropdownFieldState();
}

class LinkedCardDropdownFieldState extends State<LinkedCardDropdownField> {
  /// Links the dropdown overlay position to this widget
  final LayerLink layerLink = LayerLink();

  /// Holds reference to the active dropdown overlay
  /// null = closed, non-null = open
  OverlayEntry? dropdownOverlay;

  /// Toggles dropdown visibility
  /// Creates overlay if closed, removes if open
  void toggleDropdown() {
    if (dropdownOverlay == null) {
      dropdownOverlay = createDropdownOverlay();
      Overlay.of(context).insert(dropdownOverlay!);
    } else {
      removeDropdown();
    }
  }

  /// Safely removes dropdown overlay from the screen
  /// Important to prevent memory leaks or duplicate overlays
  void removeDropdown() {
    dropdownOverlay?.remove();
    dropdownOverlay = null;
  }

  /// Builds the floating dropdown overlay
  /// Positioned relative to the TextField using CompositedTransformFollower
  OverlayEntry createDropdownOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width, // Matches width of the input field
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, size.height + 4), // Positions dropdown below field
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true, // Prevents full screen expansion
              children: widget.cards.map((card) {
                return ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: Text(card),

                  /// When a card is selected:
                  /// 1. Update the text field value
                  /// 2. Close the dropdown
                  onTap: () {
                    widget.controller.text = card;
                    removeDropdown();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /// Ensure overlay is removed when widget is destroyed
    /// Prevents orphaned overlays in widget tree
    removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink, // Anchor point for dropdown positioning
      child: SizedBox(
        height: widget.height ?? 48,
        width: widget.width,
        child: TextFormField(
          controller: widget.controller,
          readOnly: true, // Prevents manual typing
          onTap: toggleDropdown, // Opens dropdown on tap
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            labelText: widget.label,

            /// Standard rounded styling
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.blue),
            ),

            /// Dropdown icon button also toggles overlay
            suffixIcon: IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: toggleDropdown,
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable text field with configurable size and optional obscuring
///
/// Use cases:
/// - Amount input
/// - Password fields
/// - Consistent UI across app
class CustomSizedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final double? height;
  final double? width;
  final bool obscureText;

  const CustomSizedTextField({
    super.key,
    required this.controller,
    this.label = 'Amount',
    this.height,
    this.width,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // Used for sensitive inputs
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          labelText: label,

          /// Consistent rounded styling across inputs
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

/// A selectable button group using tactile feedback and gradient styling
///
/// Behavior:
/// - Only one option can be selected at a time
/// - Selected button visually highlighted
/// - Used for actions like Transfer / Deposit / Send
class SelectableTactile extends StatefulWidget {
  const SelectableTactile({super.key});

  @override
  State<SelectableTactile> createState() => SelectableTactileState();
}

class SelectableTactileState extends State<SelectableTactile> {
  /// Tracks currently selected button index
  /// -1 means nothing selected
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> buttonLabels = ['Transfer', 'Deposit', 'Send'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttonLabels.length, (index) {
        final bool isSelected = selectedIndex == index;

        return TactileButton(
          onTap: () {
            /// Updates selected state and triggers UI rebuild
            setState(() {
              selectedIndex = index;
            });
          },
          child: GradientContainer(
            /// Apply gradient only when selected
            gradient1: isSelected ? Colors.blue : Colors.transparent,
            gradient2: isSelected
                ? const Color.fromARGB(255, 85, 221, 89)
                : Colors.transparent,

            height: 1.h(context),
            width: 1.h(context),

            neonGlow: tran, // Custom glow effect from theme
            text: buttonLabels[index],
            textSize: 3.sp(context),

            /// Subtle border for unselected state
            borderColor: Colors.white38,
            borderRadius: 500, // Fully rounded (pill shape)
          ),
        );
      }),
    );
  }
}
