import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/tactile_button.dart";

class PillButton extends StatelessWidget {
  PillButton(
      {super.key,
      this.text,
      required this.onTap,
      required this.textSize,
      required this.scale,
      required this.padding,
      required this.color,
      required this.textColor,
      required this.borderRadius,
      required this.borderColor});

  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final String? text;
  final double textSize;
  final double borderRadius;
  double scale = 1.03;
  Color color = tran;
  Color textColor = tran;
  Color borderColor = deckBorderColor;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: onTap,
        scale: scale,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor),
            color: color,
          ),
          child: Text(
            text ?? '',
            style: TextStyle(fontSize: textSize),
          ),
        ));
  }
}
