import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/firebase_tools/username_change.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import '../../util/auth/login.dart';
import '../mobile/mobile_finance_page.dart';
import '../tablet/tablet_finance_page.dart';
import 'desk_decks.dart';

// Screen dimension variables to use instead of MediaQuery (context)
final double screenHeight = window.physicalSize.height / window.devicePixelRatio;
final double screenWidth = window.physicalSize.width / window.devicePixelRatio;

// Responsive variables

class ProfileBubble extends StatefulWidget {
  final double deckHeight;
  final double deckWidth;
  final String deckName;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final VoidCallback? onTap;

  const ProfileBubble({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileBubble> createState() => _ProfileBubbleState();
}

class _ProfileBubbleState extends State<ProfileBubble> {
  final Color shadowColor = Colors.white;

  final Color buttonColor = const Color.fromARGB(255, 29, 29, 29);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(134, 10, 10, 10),
              Color.fromARGB(230, 24, 24, 24),
            ],
            transform: GradientRotation(180),
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color.fromARGB(147, 36, 36, 36)),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color.fromARGB(255, 8, 8, 8),
              offset: Offset(0, 0),
            ),
          ],
        ),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1080),
        height: widget.deckHeight,
        width: widget.deckWidth,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [widget.gradient1, widget.gradient2]),
                  boxShadow: [BoxShadow(color: widget.neonGlow, blurRadius: 20, blurStyle: BlurStyle.solid)],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/crest5.png', width: 35),
                      Text(
                        widget.deckName,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: shadowColor, blurRadius: 1),
                            Shadow(color: shadowColor, blurRadius: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DockButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const DockButton({
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _DockButtonState createState() => _DockButtonState();
}

class _DockButtonState extends State<DockButton> {
  Control control = Control.stop;
  Color activeColor = Colors.white;
  Color inactiveColor = Colors.white30;
  Color currentColor = Colors.white30;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CustomAnimationBuilder<double>(
        control: control,
        startPosition: 0,
        tween: Tween(begin: 2, end: 1.5),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        onCompleted: reverseShrink,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: IconButton(
          icon: Icon(widget.icon),
          color: currentColor,
          onPressed: toggleShrink,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
    );
  }

  void toggleShrink() {
    setState(() {
      control = Control.play;
      currentColor = (currentColor == activeColor) ? inactiveColor : activeColor;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}

class MTProfileCard extends StatefulWidget {
  const MTProfileCard({
    super.key,
  });

  @override
  State<MTProfileCard> createState() => _MTProfileCardState();
}

class _MTProfileCardState extends State<MTProfileCard> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState
    // responsiveDeck();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // deckHeight = 22.h(context);
    // deckWidth = 35.25.w(context);
    // halfDeckWidth = 17.325.w(context);
    // labelTextSize = 16;

    var screenWidth = window.physicalSize.width / window.devicePixelRatio;

    return TactileButton(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  animation = CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  if (screenWidth < 550) {
                    return MobFinancePage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return TabFinancePage(
                      transitionAnimation: animation,
                    );
                  }
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: ScaleTransition(
        scale: scale,
        child: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 300),
          child: profileCard(),
        ),
      ),
    );
  }

  Widget profileCard({VoidCallback? onTap, Color? color}) {
    double deckHeight = 22.sp(context);
    double deckWidth = 35.25.w(context);
    double halfDeckWidth = 17.325.w(context);
    double headerTextSize = 6.5.sp(context);
    subTextSize = 2.5.sp(context);
    profBubTextSize = 20;
    double labelTextSize = 3.sp(context);
    textConstraint = 500;
    subTextConstraint = 500;
    return Deck(
      deckHeight: 20.h(context),
      deckWidth: halfDeckWidth,
      deckName: '',
      gradient1: tran,
      gradient2: tran,
      neonGlow: tran,
      labelTextSize: labelTextSize,
      textConstraint: halfDeckWidth * 0.8,
      headingText: getCurrentUsername(),
      subText: '',
    );
  }
}
