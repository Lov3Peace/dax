import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import 'mobile_finance_page.dart';
import 'mobile_news_page.dart';
import 'mobile_projects_page.dart';
import 'mobile_socials_page.dart';
import '../../util/auth/login.dart';

//screen dimension variables to use instead of MediaQuery (context)
var screenHeight = window.physicalSize.height / window.devicePixelRatio;
var screenWidth = window.physicalSize.width / window.devicePixelRatio;

//responsive variables
double deckHeight = screenHeight * 0.22;
double deckWidth = screenWidth * 0.90;
double halfDeckWidth = screenWidth * 0.45;
double headerTextSize = 24;
double subTextSize = 14;
double profBubTextSize = 20;
double titleTextSize = 20;

class Deck extends StatelessWidget {
  Deck({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    this.text,
    this.subText,
    this.textConstraint,
    this.image,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  Text? text;
  Text? subText;
  double? textConstraint;
  Image? image;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(164, 0, 0, 0),
            Color.fromARGB(59, 15, 15, 15),
          ], transform: GradientRotation(180)),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color.fromARGB(149, 41, 41, 41)),
          boxShadow: const [
            // BoxShadow(
            //   blurRadius: 5,
            //   color: Color.fromARGB(255, 14, 14, 14),
            //   offset: Offset(5, 5),
            // ),
            //   BoxShadow(
            //     blurRadius: 10,
            //     color: Color.fromARGB(255, 37, 37, 37),
            //     offset: Offset(-5, -5),
            //   )
          ],
        ),
        constraints: const BoxConstraints(),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          children: [
            //
            // Description text
            //
            Positioned(
              left: 25,
              top: 20,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: text),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: subText)
                ],
              ),
            ),
            Positioned(
              left: 300,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: image),
                ],
              ),
            ),

            // Card label

            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 25),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [gradient1, gradient2]),
                      boxShadow: [
                        BoxShadow(
                            color: neonGlow,
                            blurRadius: 7,
                            blurStyle: BlurStyle.solid)
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      deckName,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 1,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 2,
                            ),
                          ]),
                    ),
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

//APPBAR FOR ALL PAGES
AppBar mobAppBar() {
  return AppBar(
    backgroundColor: tran,
    shadowColor: tran,
    automaticallyImplyLeading: false,
    leadingWidth: screenWidth * 0.9,
    toolbarHeight: lerpDouble(0, 10, 8),
    flexibleSpace: Padding(
      padding: EdgeInsets.fromLTRB(screenWidth * .05, 30, screenWidth * .05, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'title',
            flightShuttleBuilder: flightShuttleBuilder,
            child: TitleBubble(
              deckHeight: screenHeight * 0.05,
              deckWidth: screenWidth * 0.4,
              deckName: 'Dashboard',
              gradient1: tran,
              gradient2: tran,
              neonGlow: const Color.fromARGB(78, 4, 4, 4),
              leftPad: 0,
            ),
          ),
          Hero(
            tag: 'profile',
            flightShuttleBuilder: flightShuttleBuilder,
            child: ProfileBubble(
              deckHeight: screenHeight * 0.05,
              deckWidth: screenWidth * 0.3,
              deckName: auth.currentUser!.email.toString().allBefore('@'),
              gradient1: tran,
              gradient2: tran,
              neonGlow: const Color.fromARGB(78, 4, 4, 4),
            ),
          ),
        ],
      ),
    ),
  );
}

//PROFILE BUBBLE FOR USERNAME/PROFILE
class ProfileBubble extends StatelessWidget {
  ProfileBubble({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(134, 10, 10, 10),
              Color.fromARGB(230, 24, 24, 24),
            ], transform: GradientRotation(180)),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color.fromARGB(147, 36, 36, 36)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color.fromARGB(255, 8, 8, 8),
                offset: Offset(0, 0),
              ),
              // BoxShadow(
              //   blurRadius: 10,
              //   color: Color.fromARGB(255, 37, 37, 37),
              //   offset: Offset(0, 0),
              // )
            ]),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1080),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradient1, gradient2]),
                    boxShadow: [
                      BoxShadow(
                          color: neonGlow,
                          blurRadius: 20,
                          blurStyle: BlurStyle.solid)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/crest5.png', width: 35),
                      Text(
                        deckName,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: shadowColor,
                                blurRadius: 1,
                              ),
                              Shadow(
                                color: shadowColor,
                                blurRadius: 2,
                              ),
                            ]),
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

//TITLE BUBBLE FOR USERNAME PROFILE
class TitleBubble extends StatelessWidget {
  TitleBubble({
    required this.deckHeight,
    required this.deckWidth,
    required this.deckName,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    required this.leftPad,
    this.textSize,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  Color gradient1;
  Color gradient2;
  Color neonGlow;
  double? textSize;
  double leftPad;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(top: 20),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(134, 10, 10, 10),
              Color.fromARGB(230, 24, 24, 24),
            ], transform: GradientRotation(180)),
            borderRadius: BorderRadius.circular(screenHeight * 0.05),
            border: Border.all(color: const Color.fromARGB(147, 36, 36, 36)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color.fromARGB(255, 8, 8, 8),
                offset: Offset(0, 0),
              ),
              // BoxShadow(
              //   blurRadius: 10,
              //   color: Color.fromARGB(255, 37, 37, 37),
              //   offset: Offset(0, 0),
              // )
            ]),
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1080),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(leftPad, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradient1, gradient2]),
                    boxShadow: [
                      BoxShadow(
                          color: neonGlow,
                          blurRadius: 20,
                          blurStyle: BlurStyle.solid)
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    deckName,
                    style: GoogleFonts.montserrat(
                        fontSize: textSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: shadowColor,
                            blurRadius: 1,
                          ),
                          Shadow(
                            color: shadowColor,
                            blurRadius: 2,
                          ),
                        ]),
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

//DOCK ICON BUTTONS CLASS
class DockButton extends StatefulWidget {
  DockButton({super.key, required this.icon, this.onPressed});
  IconData icon;
  VoidCallback? onPressed;
  @override
  State<DockButton> createState() => _DockButtonState();
}

class _DockButtonState extends State<DockButton> {
  Control control = Control.stop;
  Color activeColor = Colors.white;
  Color inactiveColor = Colors.white30;
  Color currentColor = Colors.white30;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      child: CustomAnimationBuilder<double>(
        control: control,
        startPosition: 0,
        tween: Tween(begin: 2, end: 1.5),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        onCompleted: () {
          reverseShrink();
        },
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
          highlightColor: tran,
          splashColor: tran,
        ),
      ),
    );
  }

  void toggleShrink() {
    // toggle between control instructions
    setState(() {
      control = Control.play;
      currentColor =
          (currentColor == activeColor) ? inactiveColor : activeColor;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}

//PROJECTS DECK ANIMATION
class ProjectsDeck extends StatefulWidget {
  const ProjectsDeck({super.key});

  @override
  State<ProjectsDeck> createState() => _ProjectsDeckState();
}

class _ProjectsDeckState extends State<ProjectsDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;

  @override
  void initState() {
    // TODO: implement initState

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
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return MobProjectsPage(
                    transitionAnimation: animation,
                  );
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
            child: projectDeck()),
      ),
    );
  }

  GestureDetector projectDeck({
    //required double deckHeight,
    //required double deckWidth,
    VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'Projects',
        gradient1: red,
        gradient2: purp,
        neonGlow: red,
        textConstraint: 200,
        image: Image.asset(
          'images/proj placeholder.webp',
          height: 20.h,
        ),
        text: Text(
          'Collaborate and innovate.',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class ProjectStacks {
  List<Widget> mobProjectStacks = [
    Hero(
      tag: 'keyboards',
      child: Deck(
        deckHeight: 500,
        deckWidth: 375,
        deckName: 'Keyboards',
        gradient1: purp,
        gradient2: red,
        neonGlow: red,
      ),
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Software Development',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Guitars',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Art',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Film',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> tabProjectStacks = [
    Hero(
      tag: 'keyboards',
      child: Deck(
        deckHeight: 500,
        deckWidth: 700,
        deckName: 'Keyboards',
        gradient1: purp,
        gradient2: red,
        neonGlow: red,
      ),
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Software Development',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Guitars',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Art',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Film',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> deskProjectStacks = [
    Hero(
      tag: 'keyboards',
      child: Deck(
        deckHeight: 500,
        deckWidth: 375,
        deckName: 'Keyboards',
        gradient1: purp,
        gradient2: red,
        neonGlow: red,
      ),
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Software Development',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Guitars',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Photography',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Art',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Film',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
    ),
    const SizedBox(height: 150)
  ];
}

//SOCIALS DECK ANIMATION
class SocialsDeck extends StatefulWidget {
  const SocialsDeck({super.key});

  @override
  State<SocialsDeck> createState() => _SocialsDeckState();
}

class _SocialsDeckState extends State<SocialsDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

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
    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
      headerTextSize = 24;
      subTextSize = 16;
    } else if (screenWidth < 1100) {
      deckHeight = screenHeight * 0.24;
      headerTextSize = 48;
      subTextSize = 14;
    } else {
      deckHeight = screenHeight * 0.26;
      deckWidth = screenWidth * 0.33;
      halfDeckWidth = screenWidth * 0.16;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return MobSocialsPage(
                    transitionAnimation: animation,
                  );
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
          child: socialsDeck(),
        ),
      ),
    );
  }

  GestureDetector socialsDeck({
    VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'Socials',
        gradient1: orange,
        gradient2: purp,
        neonGlow: orange,
        textConstraint: 300,
        text: Text(
          'All of your socials in one place.',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class SocialsStacks {
  List<Widget> mobSocialsStacks = [
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Instagram',
      gradient1: Colors.orange,
      gradient2: purp,
      neonGlow: Colors.deepOrange,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Twitter',
      gradient1: const Color.fromARGB(255, 31, 154, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'Facebook',
      gradient1: const Color.fromARGB(255, 12, 89, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 200,
      deckWidth: 375,
      deckName: 'TikTok',
      gradient1: const Color.fromARGB(255, 255, 63, 121),
      gradient2: Colors.cyanAccent,
      neonGlow: const Color.fromARGB(255, 255, 91, 140),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> tabSocialsStacks = [
    Deck(
      deckHeight: 250,
      deckWidth: screenWidth * 0.85,
      deckName: 'Instagram',
      gradient1: Colors.orange,
      gradient2: purp,
      neonGlow: Colors.deepOrange,
    ),
    Deck(
      deckHeight: 250,
      deckWidth: screenWidth * 0.85,
      deckName: 'Twitter',
      gradient1: const Color.fromARGB(255, 31, 154, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 250,
      deckWidth: screenWidth * 0.85,
      deckName: 'Facebook',
      gradient1: const Color.fromARGB(255, 12, 89, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 250,
      deckWidth: screenWidth * 0.85,
      deckName: 'TikTok',
      gradient1: const Color.fromARGB(255, 255, 63, 121),
      gradient2: Colors.cyanAccent,
      neonGlow: const Color.fromARGB(255, 255, 91, 140),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> deskSocialsStacks = [
    Deck(
      deckHeight: 300,
      deckWidth: 425,
      deckName: 'Instagram',
      gradient1: Colors.orange,
      gradient2: purp,
      neonGlow: Colors.deepOrange,
    ),
    Deck(
      deckHeight: 300,
      deckWidth: 425,
      deckName: 'Twitter',
      gradient1: const Color.fromARGB(255, 31, 154, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 300,
      deckWidth: 425,
      deckName: 'Facebook',
      gradient1: const Color.fromARGB(255, 12, 89, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 300,
      deckWidth: 425,
      deckName: 'TikTok',
      gradient1: const Color.fromARGB(255, 255, 63, 121),
      gradient2: Colors.cyanAccent,
      neonGlow: const Color.fromARGB(255, 255, 91, 140),
    ),
    const SizedBox(height: 150)
  ];
}

//FINACNES DECK ANIMATION
class FinancesDeck extends StatefulWidget {
  const FinancesDeck({
    super.key,
  });

  @override
  State<FinancesDeck> createState() => _FinancesDeckState();
}

class _FinancesDeckState extends State<FinancesDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

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
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return MobFinancePage(
                    transitionAnimation: animation,
                  );
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
          child: financesDeck(),
        ),
      ),
    );
  }

  GestureDetector financesDeck({VoidCallback? onTap, Color? color}) {
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: halfDeckWidth,
        deckName: 'Finances',
        gradient1: green,
        gradient2: blue,
        neonGlow: green,
        textConstraint: 150,
        text: Text(
          'Manage your money.',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class FinancesStacks {
  List<Widget> mobFinancesStacks = [
    Deck(
      deckHeight: 100,
      deckWidth: 375,
      deckName: 'Balance',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Investments',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> tabFinancesStacks = [
    Deck(
      deckHeight: 300,
      deckWidth: deckWidth * 0.85,
      deckName: 'Balance',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: 300,
      deckWidth: deckWidth * 0.85,
      deckName: 'Current Investments',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: 300,
      deckWidth: deckWidth * 0.85,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> deskFinancesStacks = [
    Deck(
      deckHeight: 100,
      deckWidth: 375,
      deckName: 'Balance',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Investments',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    Deck(
      deckHeight: DeckHeight().deckHeight,
      deckWidth: 375,
      deckName: 'Current Loans',
      gradient1: const Color.fromARGB(255, 157, 255, 45),
      gradient2: const Color.fromARGB(255, 59, 193, 255),
      neonGlow: const Color.fromARGB(129, 157, 255, 45),
    ),
    const SizedBox(height: 150)
  ];
}

//NEWS DECK ANIMATION
class NewsDeck extends StatefulWidget {
  const NewsDeck({
    super.key,
  });

  @override
  State<NewsDeck> createState() => _NewsDeckState();
}

class _NewsDeckState extends State<NewsDeck> with AnimationMixin {
  @override
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState

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
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.play();
          Future.delayed(const Duration(milliseconds: 100)).then((_) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.linear);
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return MobNewsPage(
                    transitionAnimation: animation,
                  );
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
          child: NewsDeck(),
        ),
      ),
    );
  }

  GestureDetector NewsDeck({VoidCallback? onTap, Color? color}) {
    return GestureDetector(
        child: Deck(
      deckHeight: deckHeight,
      deckWidth: halfDeckWidth,
      deckName: 'News',
      gradient1: blue,
      gradient2: purp,
      neonGlow: blue,
      textConstraint: 150,
      text: Text(
        'Stay up to date.',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
            fontWeight: FontWeight.w600),
      ),
    ));
  }
}

class NewsStacks {
  List<Widget> mobNewsStacks = [
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Trending',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Local News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'World News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Economic News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> tabNewsStacks = [
    Deck(
      deckHeight: 225,
      deckWidth: deckWidth * 0.85,
      deckName: 'Trending',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: deckWidth * 0.85,
      deckName: 'Local News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: deckWidth * 0.85,
      deckName: 'World News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: deckWidth * 0.85,
      deckName: 'Economic News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    const SizedBox(height: 150)
  ];
  List<Widget> deskNewsStacks = [
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Trending',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Local News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'World News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    Deck(
      deckHeight: 225,
      deckWidth: 375,
      deckName: 'Economic News',
      gradient1: const Color.fromARGB(255, 59, 193, 255),
      gradient2: purp,
      neonGlow: const Color.fromARGB(255, 59, 193, 255),
    ),
    const SizedBox(height: 150)
  ];
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 55),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [purp, red]),
          boxShadow: const [
            BoxShadow(color: red, blurRadius: 20, blurStyle: BlurStyle.solid)
          ],
          borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
      child: const Center(
        child: Text(
          'Log Out',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class Stacks extends Deck {
  Stacks(
      {super.key,
      required super.deckHeight,
      required super.deckWidth,
      required super.deckName,
      required super.gradient1,
      required super.gradient2,
      required super.neonGlow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(164, 0, 0, 0),
            Color.fromARGB(59, 15, 15, 15),
          ], transform: GradientRotation(180)),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color.fromARGB(149, 41, 41, 41)),
          boxShadow: const [],
        ),
        constraints: const BoxConstraints(),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          children: [
            //
            // Description text
            //
            Positioned(
              left: 25,
              top: 20,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: text),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: subText)
                ],
              ),
            ),
            Positioned(
              left: 300,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: textConstraint,
                      child: image),
                ],
              ),
            ),

            // Card label

            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 25),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [gradient1, gradient2]),
                      boxShadow: [
                        BoxShadow(
                            color: neonGlow,
                            blurRadius: 7,
                            blurStyle: BlurStyle.solid)
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      deckName,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 1,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 2,
                            ),
                          ]),
                    ),
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
