import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_project_page.dart';
import 'package:flutter_application_1/responsive/desktop/desk_socials_page.dart';
import 'package:flutter_application_1/responsive/responsive_meth.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_finance_page.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_news_page.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_projects_page.dart';
import 'package:flutter_application_1/responsive/tablet/tablet_socials_page.dart';
import 'package:flutter_application_1/util/deck_height_value.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as r;
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import '../../util/auth/login.dart';
import '../mobile/mobile_finance_page.dart';
import '../mobile/mobile_news_page.dart';
import '../mobile/mobile_projects_page.dart';
import '../mobile/mobile_socials_page.dart';
import 'desk_finance_page.dart';
import 'desk_news_page.dart';

//screen dimension variables to use instead of MediaQuery (context)
var screenHeight = window.physicalSize.height / window.devicePixelRatio;
var screenWidth = window.physicalSize.width / window.devicePixelRatio;

//responsive variables
double deckHeight = 22.h;
double deckWidth = 35.25.w;
double halfDeckWidth = 17.325.w;
double headerTextSize = 24;
double subTextSize = 14;
double profBubTextSize = 20;
double titleTextSize = 20;
double labelTextSize = 16;
double? textConstraint = 500;
double? subTextConstraint = 500;
Color deckBorderColor = Color.fromARGB(182, 75, 75, 75);

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
    this.labelTextSize,
    this.textConstraint,
    this.image,
    this.onTap,
    this.subTextConstraint,
    this.riveAnim,
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
  double? labelTextSize;
  double? textConstraint;
  double? subTextConstraint;
  r.RiveAnimation? riveAnim;
  Image? image;
  VoidCallback? onTap;
  Color shadowColor = Colors.white;
  Color buttonColor = const Color.fromARGB(255, 29, 29, 29);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.5.w),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: tran,
          // margin: const EdgeInsets.only(top: 20),
          // constraints: const BoxConstraints(minWidth: 500, minHeight: 500),
          height: deckHeight,
          width: deckWidth,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                blendMode: BlendMode.darken,
                child: const SizedBox(),
              ),

              //Deck Color with Glass Effect
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5.w),
                  color: Color.fromARGB(185, 21, 19, 22),

                  border: Border.all(color: deckBorderColor),
                  // boxShadow: const [
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
                  // ],
                ),
              ),
              //
              // Title/Description text
              Positioned(
                left: 0,
                top: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Heading
                    Container(
                        constraints: BoxConstraints(maxWidth: deckWidth * 0.9),
                        margin:
                            EdgeInsets.fromLTRB(2.w, deckHeight * 0.12, 2.w, 0),
                        width: textConstraint,
                        child: text),
                    //Subheading
                    Container(
                        constraints: BoxConstraints(maxWidth: deckWidth * 0.9),
                        margin: EdgeInsets.fromLTRB(2.w, 0.5.w, 2.w, 0),
                        width: subTextConstraint,
                        child: subText)
                  ],
                ),
              ),
              //
              //Image
              Positioned(
                left: deckWidth * 0.5,
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        width: textConstraint,
                        child: image),
                  ],
                ),
              ),
              Positioned(
                left: deckWidth * 0.6,
                bottom: deckHeight * 0.1,
                child: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: deckHeight, maxWidth: deckHeight),
                        margin: const EdgeInsets.only(bottom: 5),
                        width: textConstraint,
                        child: riveAnim),
                  ],
                ),
              ),
              //
              // Card label
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 0, 0, 2.w),
                  child: Container(
                    constraints:
                        const BoxConstraints(minHeight: 50, maxHeight: 160),
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [gradient1, gradient2]),
                        boxShadow: [
                          BoxShadow(
                              color: neonGlow,
                              blurRadius: 17,
                              blurStyle: BlurStyle.solid)
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(500))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(2.w, 20, 2.w, 20),
                      child: Text(
                        deckName,
                        style: GoogleFonts.montserrat(
                            fontSize: labelTextSize,
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
      ),
    );
  }
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
    required this.leftPad,
    required this.textSize,
    this.onTap,
    super.key,
  });

  double deckHeight;
  double deckWidth;
  String deckName;
  double textSize;
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
        // margin: const EdgeInsets.only(top: 20),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.5.w),
          color: Color.fromARGB(238, 21, 19, 22),
          border: Border.all(color: Color.fromARGB(182, 73, 73, 73)),
        ),
        constraints: const BoxConstraints(
            maxHeight: 600, maxWidth: 1080, minWidth: 250, minHeight: 50),
        height: deckHeight,
        width: deckWidth,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(leftPad, 0, 0, 0),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [tran, tran]),
                    boxShadow: [
                      BoxShadow(
                          color: tran,
                          blurRadius: 20,
                          blurStyle: BlurStyle.solid)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    deckName,
                    style: GoogleFonts.montserrat(
                      fontSize: textSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    // if (screenWidth < 550) {
    //   deckHeight = screenHeight * 0.22;
    //   headerTextSize = 24;
    //   subTextSize = 16;
    // } else if (screenWidth < 1000) {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    //   subTextSize = 14;
    // } else {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    // }
    return TactileButton(
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
                  if (screenWidth < 550) {
                    return MobProjectsPage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabProjectsPage(
                      transitionAnimation: animation,
                    );
                  } else {
                    // ignore: prefer_const_constructors
                    return DeskProjectsPageDash(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 1200),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: projectDeck(),
    );
  }

  Widget projectDeck({
    //required double deckHeight,
    //required double deckWidth,
    VoidCallback? onTap,
    Color? color,
  }) {
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'Projects',
      gradient1: red,
      gradient2: purp,
      neonGlow: red,
      labelTextSize: labelTextSize,
      textConstraint: deckWidth * 0.7,
      subTextConstraint: deckWidth * 0.6,
      // image: Image.asset(
      //   'images/proj placeholder.webp',
      //   height: screenWidth * 0.1,
      // ),
      text: Text(
        'Collaborate and innovate.',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
            fontWeight: FontWeight.w600),
      ),
      subText: Text(
        'Post, join, or support independent projects anywhere in the world.',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: subTextSize, height: 1.25),
            fontWeight: FontWeight.w400),
      ),
      riveAnim: const r.RiveAnimation.asset('rive/building_apartments.riv'),
    );
  }
}

class ProjectStacks {
  List<Widget> mobProjectStacks = [
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Keyboards',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
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
    Deck(
      deckHeight: 500,
      deckWidth: 700,
      deckName: 'Keyboards',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
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
    Deck(
      deckHeight: 500,
      deckWidth: 375,
      deckName: 'Keyboards',
      gradient1: purp,
      gradient2: red,
      neonGlow: red,
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
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    // if (screenWidth < 550) {
    //   deckHeight = screenHeight * 0.22;
    //   headerTextSize = 24;
    //   subTextSize = 16;
    // } else if (screenWidth < 1000) {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    //   subTextSize = 14;
    // } else {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    // }
    return TactileButton(
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
                  if (screenWidth < 550) {
                    return MobSocialsPage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabSocialsPage(
                      transitionAnimation: animation,
                    );
                  } else {
                    // ignore: prefer_const_constructors
                    return DeskSocialsPageDash(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 700),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: socialsDeck(),
    );
  }

  Widget socialsDeck({
    VoidCallback? onTap,
    Color? color,
  }) {
    return Deck(
      deckHeight: deckHeight,
      deckWidth: deckWidth,
      deckName: 'Socials',
      gradient1: orange,
      gradient2: purp,
      neonGlow: orange,
      labelTextSize: labelTextSize,
      textConstraint: deckWidth * 0.9,
      text: Text(
        'All of your socials in one place.',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
            fontWeight: FontWeight.w600),
      ),
      subText: Text(
        'Just link your social media accounts and access them all in one place.',
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: subTextSize, height: 1.25),
            fontWeight: FontWeight.w400),
      ),
      subTextConstraint: deckWidth * 0.6,
      riveAnim: const r.RiveAnimation.asset(
        "rive/twitter_rv.riv",
        fit: BoxFit.fitWidth,
      ),
      // image: Image.asset('images/crest1.png'),
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
      deckHeight: 400,
      deckWidth: 675,
      deckName: 'Instagram',
      gradient1: Colors.orange,
      gradient2: purp,
      neonGlow: Colors.deepOrange,
    ),
    Deck(
      deckHeight: 400,
      deckWidth: 675,
      deckName: 'Twitter',
      gradient1: const Color.fromARGB(255, 31, 154, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 400,
      deckWidth: 675,
      deckName: 'Facebook',
      gradient1: const Color.fromARGB(255, 12, 89, 255),
      gradient2: const Color.fromARGB(255, 151, 205, 255),
      neonGlow: Colors.blue,
    ),
    Deck(
      deckHeight: 400,
      deckWidth: 675,
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
    deckHeight = 22.h;
    deckWidth = 35.25.w;
    halfDeckWidth = 17.325.w;
    labelTextSize = 16;
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
      headerTextSize = 24;
      subTextSize = 16;
    } else if (screenWidth < 1500) {
      deckWidth = 35.25.w;
      headerTextSize = 30;
      textConstraint = halfDeckWidth * 0.7;
    } else if (screenWidth <= 1920) {
      deckWidth = 35.25.w;
      headerTextSize = 40;
      subTextSize = 22;
    } else if (screenWidth < 2600) {
      deckWidth = 35.25.w;
      headerTextSize = 48;
      subTextSize = 24;
    } else {
      deckWidth = 35.25.w;
      headerTextSize = 85;
      subTextSize = 30;
      labelTextSize = 22;
    }
    return TactileButton(
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
                  if (screenWidth < 550) {
                    return MobFinancePage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabFinancePage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return DeskFinancesPageDash(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 700),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: financesDeck(),
    );
  }

  Widget financesDeck({VoidCallback? onTap, Color? color}) {
    return GestureDetector(
      child: Deck(
        deckHeight: 20.h,
        deckWidth: halfDeckWidth,
        deckName: 'Finances',
        gradient1: green,
        gradient2: blue,
        neonGlow: green,
        labelTextSize: labelTextSize,
        textConstraint: halfDeckWidth * 0.8,
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
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    // if (screenWidth < 550) {
    //   deckHeight = screenHeight * 0.22;
    //   headerTextSize = 24;
    //   subTextSize = 16;
    // } else if (screenWidth < 1000) {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    //   subTextSize = 14;
    // } else {
    //   deckHeight = 40.h;
    //   halfDeckWidth = 18.w;
    //   deckWidth = 37.w;
    //   headerTextSize = 10.sp;
    // }
    return TactileButton(
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
                  if (screenWidth < 550) {
                    return MobNewsPage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabNewsPage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return DeskNewsPageDash(
                        //transitionAnimation: animation,
                        );
                  }
                },
                transitionDuration: const Duration(milliseconds: 700),
              ),
            );
          });
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            controller.reset();
          });
        });
      },
      child: newsDeck(),
    );
  }

  Widget newsDeck({VoidCallback? onTap, Color? color}) {
    return GestureDetector(
      child: Deck(
        deckHeight: deckHeight,
        deckWidth: deckWidth,
        deckName: 'News',
        gradient1: blue,
        gradient2: purp,
        neonGlow: blue,
        labelTextSize: labelTextSize,
        textConstraint: deckWidth * 0.7,
        text: Text(
          'Stay up to date.',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
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

class ProfileCard extends StatefulWidget {
  ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> with AnimationMixin {
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
    deckHeight = 22.h;
    deckWidth = 35.25.w;
    halfDeckWidth = 17.325.w;
    labelTextSize = 16;
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    if (screenWidth < 550) {
      deckHeight = screenHeight * 0.22;
      headerTextSize = 24;
      subTextSize = 16;
    } else if (screenWidth < 1500) {
      deckWidth = 35.25.w;
      headerTextSize = 30;
      textConstraint = halfDeckWidth * 0.7;
    } else if (screenWidth <= 1920) {
      deckWidth = 35.25.w;
      headerTextSize = 40;
      subTextSize = 22;
    } else if (screenWidth < 2600) {
      deckWidth = 35.25.w;
      headerTextSize = 48;
      subTextSize = 24;
    } else {
      deckWidth = 35.25.w;
      headerTextSize = 85;
      subTextSize = 30;
      labelTextSize = 22;
    }
    return TactileButton(
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
                  if (screenWidth < 550) {
                    return MobFinancePage(
                      transitionAnimation: animation,
                    );
                  } else if (screenWidth < 1100) {
                    return TabFinancePage(
                      transitionAnimation: animation,
                    );
                  } else {
                    return MobFinancePage(
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
    return Deck(
      deckHeight: 20.h,
      deckWidth: halfDeckWidth,
      deckName: '',
      gradient1: tran,
      gradient2: tran,
      neonGlow: tran,
      labelTextSize: labelTextSize,
      textConstraint: halfDeckWidth * 0.8,
      text: Text(
        auth.currentUser!.email.toString().allBefore('@'),
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(fontSize: headerTextSize, height: 1.0),
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
