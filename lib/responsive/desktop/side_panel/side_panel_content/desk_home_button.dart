import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';

class DeskHomeButton extends StatefulWidget {
  const DeskHomeButton(
      {super.key, this.text = "Home", required this.hoverWidth});
  final String text;
  final double hoverWidth;

  @override
  State<DeskHomeButton> createState() => _DeskHomeButtonState();
}

class _DeskHomeButtonState extends State<DeskHomeButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          router.go("/");
        },
        child: Stack(
          children: [
            // Animated background rail that expands on hover.
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [red, pink]),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: isHover ? widget.hoverWidth : 0.25.w(context),
                  height: 7.sp(context),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 7.sp(context),
                  ),
                ),
              ],
            ),

            // Foreground content stays fixed while the background animates beneath it.
            Positioned(
              top: 1.sp(context),
              left: 0.5.w(context),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w(context)),
                    child: Icon(
                      Icons.dashboard_rounded,
                      size: 5.sp(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w(context)),
                    child: Text(
                      widget.text,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 2.sp(context)),
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
