import 'package:flutter/material.dart';

class LinkedCardDropdownField extends StatefulWidget {
  final List<String> cards;
  final TextEditingController controller;
  final String label;
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
  State<LinkedCardDropdownField> createState() => LinkedCardDropdownFieldState();
}

class LinkedCardDropdownFieldState extends State<LinkedCardDropdownField> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? dropdownOverlay;

  void toggleDropdown() {
    if (dropdownOverlay == null) {
      dropdownOverlay = createDropdownOverlay();
      Overlay.of(context).insert(dropdownOverlay!);
    } else {
      removeDropdown();
    }
  }

  void removeDropdown() {
    dropdownOverlay?.remove();
    dropdownOverlay = null;
  }

  OverlayEntry createDropdownOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, size.height + 4),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.cards.map((card) {
                return ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: Text(card),
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
    removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: SizedBox(
        height: widget.height ?? 48,
        width: widget.width,
        child: TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: toggleDropdown,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            labelText: widget.label,
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
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          labelText: label,
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
