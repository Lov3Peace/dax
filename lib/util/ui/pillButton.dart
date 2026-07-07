import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/tactile_button.dart";

class PillButton extends StatelessWidget {
  PillButton(
      {super.key,
      this.text,
      required this.onTap,
      this.isLoading = false,
      required this.textSize,
      required this.scale,
      required this.padding,
      this.color1 = tran,
      this.color2 = tran,
      required this.textColor,
      required this.borderRadius,
      required this.borderColor});

  final VoidCallback onTap;
  bool isLoading;
  final EdgeInsetsGeometry padding;
  final String? text;
  final double textSize;
  final double borderRadius;
  double scale = 1.03;
  Color color1 = tran;
  Color color2 = tran;
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
            gradient: LinearGradient(colors: [color1, color2]),
          ),
          child: Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: Text(
                  text ?? '',
                  style: TextStyle(fontSize: textSize),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: SizedBox(
                  height: 1.w(context),
                  width: 1.w(context),
                  child: CircularProgressIndicator(
                    color: white,
                    strokeWidth: 2,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
