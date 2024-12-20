import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/ButtonState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SlideButton extends StatefulWidget {
  final String deskButtonId;
  final IconData icon;
  final String deskButtonText;

  const SlideButton({
    required this.deskButtonId,
    required this.icon,
    required this.deskButtonText,
    Key? key,
  }) : super(key: key);

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    var buttonState = Provider.of<ButtonState>(context);
    bool isActive = buttonState.activeDeskButtonId == widget.deskButtonId;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHover = true;
          // print(isHover);
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
          // print(isHover);
        });
      },
      child: GestureDetector(
        onTap: () {
          buttonState.setActiveDeskButton(widget.deskButtonId);
          buttonState.callDeskFunctionForButton(widget.deskButtonId);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: isActive || isHover ? 10 : 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive || isHover ? Colors.black87 : Colors.transparent,
            ),
            boxShadow: isActive
                ? [
                    const BoxShadow(
                      color: Color.fromARGB(125, 155, 39, 176),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]
                : isHover
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          spreadRadius: 1,
                          blurRadius: 0,
                          // changes position of shadow
                        ),
                      ]
                    : [],
            gradient: isActive
                ? const LinearGradient(
                    colors: [red, purp],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(60),
          ),
          width: 13.w,
          height: 5.h,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 0.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: isActive
                      ? Colors.white
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : Colors.white70,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: .5.w),
                  child: Text(
                    widget.deskButtonText,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 2.sp),
                      fontWeight: FontWeight.w400,
                      color: isActive ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReverseSlideButton extends StatelessWidget {
  final String deskButtonId;
  final IconData icon;

  const ReverseSlideButton({
    required this.deskButtonId,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonState = Provider.of<ButtonState>(context);
    final ValueNotifier<bool> isHovering = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) {
          return IconButton(
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: value != null ? [red, purp] : [Colors.white70, Colors.white70],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Icon(icon, color: Colors.white),
            ),
            onPressed: () {
              buttonState.reverseSlide(buttonState.getSlideType(deskButtonId));
              buttonState.deactivateDeskButton();
            },
          );
        },
      ),
    );
  }
}

// class DimOverlay extends StatelessWidget {
//   const DimOverlay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var buttonState = Provider.of<ButtonState>(context);

//     return ValueListenableBuilder(
//       valueListenable: buttonState.isDimmed,
//       builder: (context, isDimmed, child) {
//         return isDimmed
//             ? Container(
//                 color: Colors.black.withOpacity(0.5),
//                 child: child,
//               )
//             : Container(
//                 color: tran,
//               );
//       },
//     );
//   }
// }
class DimOverlay extends StatelessWidget {
  const DimOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    var buttonState = Provider.of<ButtonState>(context);

    return ValueListenableBuilder<bool>(
      valueListenable: buttonState.isDimmed,
      builder: (context, isDimmed, child) {
        return AnimatedOpacity(
          opacity: isDimmed ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300), // Adjust the duration as needed
          curve: Curves.easeInBack, // Apply a curve to the opacity transition
          child: IgnorePointer(
            ignoring: !isDimmed,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }
}
