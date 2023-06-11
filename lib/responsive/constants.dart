import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import 'package:simple_animations/simple_animations.dart';
import '../pages/finance_page.dart';
import '../pages/news_page.dart';
import '../pages/projects_page.dart';
import '../pages/socials_page.dart';
import '../util/decks.dart';
import '../util/profile_bubble.dart';
import '../util/title_bubble.dart';
import 'package:google_fonts/google_fonts.dart';

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

//APPBAR FOR ALL PAGES
AppBar mobTabAppBar(
    {required double titleBubbleHeight,
    required double titleBubbleWidth,
    required double profileBubbleHeight,
    required double profileBubbleWidth}) {
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
              deckHeight: titleBubbleHeight,
              deckWidth: titleBubbleWidth,
              deckName: 'Dashboard',
              gradient1: tran,
              gradient2: tran,
              neonGlow: tran,
              leftPad: 0,
            ),
          ),
          Hero(
            tag: 'profile',
            flightShuttleBuilder: flightShuttleBuilder,
            child: ProfileBubble(
              deckHeight: profileBubbleHeight,
              deckWidth: profileBubbleWidth,
              deckName: 's3rv',
              gradient1: tran,
              gradient2: tran,
              neonGlow: tran,
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar deskAppBar() {
  if (screenWidth > 1100) {
    titleTextSize = 40;
  }
  return AppBar(
    backgroundColor: tran,
    shadowColor: tran,
    automaticallyImplyLeading: false,
    leadingWidth: screenWidth * 0.9,
    toolbarHeight: lerpDouble(0, 18, 8),
    flexibleSpace: Padding(
      padding: EdgeInsets.fromLTRB(screenWidth * .05, 30, screenWidth * .05, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'title',
            flightShuttleBuilder: flightShuttleBuilder,
            child: TitleBubble(
              deckHeight: screenHeight * 0.07,
              deckWidth: screenWidth * 0.30,
              deckName: 'Dashboard',
              gradient1: tran,
              gradient2: tran,
              neonGlow: tran,
              textSize: titleTextSize,
              leftPad: 30,
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
  ProjectsDeck({super.key});

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
    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
      headerTextSize = 20;
      subTextSize = 16;
    } else if (screenWidth < 1100) {
      deckHeight = screenHeight * 0.24;
      headerTextSize = 24;
      subTextSize = 14;
    } else {
      deckHeight = screenHeight * 0.26;
      deckWidth = screenWidth * 0.33;
      halfDeckWidth = screenWidth * 0.16;
    }

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
                  return ProjectsPage(
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
        textConstraint: 270,
        image: Image.asset(
          'images/proj placeholder.webp',
          height: 80,
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

//SOCIALS DECK ANIMATION
class SocialsDeck extends StatefulWidget {
  SocialsDeck({super.key});

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
                  return SocialsPage(
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
        textConstraint: 270,
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

//FINACNES DECK ANIMATION
class FinancesDeck extends StatefulWidget {
  FinancesDeck({
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
                  return FinancePage(
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

//NEWS DECK ANIMATION
class NewsDeck extends StatefulWidget {
  NewsDeck({
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
                  return NewsPage(
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
