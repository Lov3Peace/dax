import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/tactile_button.dart";

class PillButton extends StatelessWidget {
  PillButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.borderRadius,
    required this.borderColor,
    this.height,
    this.width,
    this.padding,
    this.scale = 1.03,
    this.isLoading = false,
    this.color1 = tran,
    this.color2 = tran,
  });

  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  bool isLoading;
  double scale;
  Color color1 = tran;
  Color color2 = tran;
  Color borderColor = deckBorderColor;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: onTap,
        scale: scale,
        child: Container(
          height: height,
          width: width,
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
                child: child,
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
              ),
            ],
          ),
        ));
  }
}
