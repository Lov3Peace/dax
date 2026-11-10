import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/tactile_button.dart";

class PillButton extends StatelessWidget {
  PillButton({
    super.key,
    required this.onTap,
    required this.width,
    required this.borderRadius,
    this.maxWidth = 500,
    this.child,
    this.text,
    this.textStyle = const TextStyle(overflow: TextOverflow.ellipsis),
    this.horizontalPadding = 10,
    this.height,
    this.scale = 1.03,
    this.isLoading = false,
    this.color1 = tran,
    this.color2 = tran,
    this.borderColor = tran,
  });

  final Widget? child;
  final VoidCallback onTap;
  final double borderRadius;
  final double horizontalPadding;
  final double? height;
  final double width;
  final String? text;
  final TextStyle? textStyle;
  final double maxWidth;
  bool isLoading;
  double scale;
  Color color1;
  Color color2;
  Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
        onTap: onTap,
        scale: scale,
        child: Container(
          height: height ?? width / 3,
          width: width,
          padding: EdgeInsetsGeometry.symmetric(horizontal: horizontalPadding),
          constraints: BoxConstraints(maxWidth: maxWidth),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor),
            gradient: LinearGradient(colors: [color1, color2]),
          ),
          // Show loading indicator if it's loading. Show text if text is null but the child if it's not. (Need text! and child ?? to bypass null
          // requirements)
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 1.w(context),
                    width: 1.w(context),
                    child: const CircularProgressIndicator(
                      color: white,
                      strokeWidth: 2,
                    ),
                  )
                : (text != null
                    ? Text(
                        text!,
                        style: textStyle,
                      )
                    : child ?? const SizedBox()),
          ),
        ));
  }
}
