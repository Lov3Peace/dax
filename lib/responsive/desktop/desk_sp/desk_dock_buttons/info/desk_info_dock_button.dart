import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/GlobalProvider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';

import '../../../../../util/tactile_button.dart';

class InfoPopUp extends StatefulWidget {
  const InfoPopUp({super.key});

  @override
  State<InfoPopUp> createState() => _InfoPopUpState();
}

class _InfoPopUpState extends State<InfoPopUp> with AnimationMixin {
  //control = Control.play;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) => CustomAnimationBuilder<double>(
        control: value.infoSlideControl,
        startPosition: 0,
        tween: Tween(begin: 0, end: 83.5.w),
        duration: const Duration(milliseconds: 1250),
        curve: Curves.easeInOutBack,
        onCompleted: () {
          final resetSlide = context.read<GlobalProvider>();
          resetSlide.infoResetSlide();
        },
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0),
            child: child,
          );
        },
        child: Center(
          child: Indexer(
            children: [
              Indexed(
                index: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
                      child: Center(
                        child: Container(
                          height: 85.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: Material(
                            shadowColor:
                                const Color.fromRGBO(42, 41, 41, 0.631),
                            color: const Color.fromARGB(42, 55, 52, 52),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(32),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                        height: 85.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  182, 31, 31, 31)),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        )),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.5.w, top: 1.h),
                                      child: Wrap(
                                        spacing: 1.5.w,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.w, bottom: 2.h),
                                                child: const Text(
                                                  'Info',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 36),
                                                ),
                                              ),
                                              //
                                              //
                                              //Container housing Info Side Panel
                                              Container(
                                                height: 67.5.h,
                                                width: 15.w,
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 500,
                                                        minHeight: 250),
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      17, 17, 17, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2.h),
                                                  child: const Column(
                                                    children: [
                                                      InfoSidePanelButtons(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //
                                          //
                                          //Container housing business info
                                          Container(
                                            height: 75.h,
                                            width: 47.w,
                                            decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(17, 17, 17, 1),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 72.5.h,
                                                  width: 45.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        25, 25, 29, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: const Column(
                                                    //crossAxisAlignment: ,
                                                    children: [
                                                      AboutUsInformation(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// Hover aspect of Info  button
class DeskInfoButtonHover extends StatefulWidget {
  const DeskInfoButtonHover({super.key});

  @override
  State<DeskInfoButtonHover> createState() => _DeskInfoButtonHoverState();
}

class _DeskInfoButtonHoverState extends State<DeskInfoButtonHover> {
//
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              final startSlide = context.read<GlobalProvider>();
              startSlide.infoActivateSlide();
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: isActive
                ? Colors.black87
                : (isHover
                    ? const Color.fromARGB(241, 255, 255, 255)
                    : Colors.white70),
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Info',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.5.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //Reverses the popup card
                      final startSlide = context.read<GlobalProvider>();
                      startSlide.infoReverseSlide();
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//This holds all the side panel buttons within the
class InfoSidePanelButtons extends StatefulWidget {
  const InfoSidePanelButtons({super.key});

  @override
  State<InfoSidePanelButtons> createState() => _InfoSidePanelButtonsState();
}

class _InfoSidePanelButtonsState extends State<InfoSidePanelButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tran,
      width: 13.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Table of Contents :',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          //
          //About Us
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const AboutUs(),
          ),

          //
          //Contact Us
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const ContactUs(),
          ),
          //
          //Goals
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const Goals(),
          ),
          //
          //Terms & Conditions
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.75.h),
            child: const TermsConditions(),
          ),
        ],
      ),
    );
  }
}

//
//
//About Us Button
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  //
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'About Us',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// About Us Information
class AboutUsInformation extends StatefulWidget {
  const AboutUsInformation({super.key});

  @override
  State<AboutUsInformation> createState() => _AboutUsInformationState();
}

class _AboutUsInformationState extends State<AboutUsInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.5.h,
      width: 45.w,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 3.w),
              child: const Text(
                'About Us',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            // Mission Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mission'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            //Origin Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Origin'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            //Founders Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Founders'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//Contact Us Button
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  //
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Contact Us',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// Contact Us Information
class ContactUsInformation extends StatefulWidget {
  const ContactUsInformation({super.key});

  @override
  State<ContactUsInformation> createState() => _ContactUsInformationState();
}

class _ContactUsInformationState extends State<ContactUsInformation> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//
//
//Goals Button
class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  //
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Goals',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//Goals Information
class GoalsInformation extends StatefulWidget {
  const GoalsInformation({super.key});

  @override
  State<GoalsInformation> createState() => _GoalsInformationState();
}

class _GoalsInformationState extends State<GoalsInformation> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//
//
// Terms & Conditions
class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  //
// start hover is false
  bool isHover = false;
  bool isHover2 = false;

//start active is false
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          setState(() {
            //
            //activates the settings popup
            if (!isActive) {
              //
              //gives the active color to be true
              isActive = true;
            }
          });
        },
        child: TactileButton(
          child: AnimatedContainer(
            padding: isActive
                ? const EdgeInsets.only(left: 10)
                : isHover
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isActive
                      ? Colors.black87
                      : isHover
                          ? Colors.black87
                          : tran),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? Colors.white
                      : (isHover ? Colors.grey.shade700 : tran),
                ),
              ],
              color: tran,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
            ),
            duration: const Duration(milliseconds: 200),
            width: 13.w,
            height: 5.h,
            alignment: Alignment.centerLeft,
            child: addElement(),
          ),
        ),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: 0.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: .5.w),
            child: Text(
              'Terms & Conditions',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : (isHover ? Colors.white : Colors.white54),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.50.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? const Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //gives the active color to be flase
                      isActive = false;
                    });
                  },
                  child: MouseRegion(
                    onEnter: (e) {
                      setState(() {
                        isHover2 = true;
                      });
                    },
                    onExit: (e) {
                      setState(() {
                        isHover2 = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: (isActive && isHover2)
                          ? red
                          : (!isHover2 && isActive)
                              ? Colors.black87
                              : tran,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//Terms & Conditions Information
class TermsConditionsInformation extends StatefulWidget {
  const TermsConditionsInformation({super.key});

  @override
  State<TermsConditionsInformation> createState() =>
      _TermsConditionsInformationState();
}

class _TermsConditionsInformationState
    extends State<TermsConditionsInformation> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
