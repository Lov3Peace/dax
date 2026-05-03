import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/newProjectForm.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';
import 'package:flutter_application_1/util/ui/gradient_label.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';

class NewProjectButton extends StatelessWidget {
  const NewProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonContainerWidth = 10.w(context);
    double buttonContainerHeight = 5.w(context);
    double buttonContainerPadding = 1.w(context);
    double buttonTextSize = 2.sp(context);
    return
        //
        // New Project Button
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0.5.w(context), 1.w(context)),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Hero(
                tag: "newProjectForm",
                flightShuttleBuilder: flightShuttleBuilder,
                // transitionOnUserGestures: true,
                child: Container(
                  padding: EdgeInsets.all(buttonContainerPadding),
                  height: buttonContainerHeight,
                  width: buttonContainerWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.w(context)),
                    color: const Color.fromARGB(185, 21, 19, 22),
                    border: Border.all(color: deckBorderColor),
                  ),
                  child: TactileButton(
                    scale: 1.05,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              opaque: false,
                              barrierDismissible: true,
                              // maintainState: true,
                              transitionDuration: Duration(milliseconds: 500),
                              // reverseTransitionDuration:
                              //     Duration(milliseconds: 300),
                              pageBuilder: (context, _, __) {
                                return Center(
                                  child: Hero(
                                    transitionOnUserGestures: true,
                                    tag: "newProjectForm",
                                    flightShuttleBuilder:
                                        textFlightShuttleBuilder2,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: NewProjectForm(),
                                    ),
                                  ),
                                );
                              }));
                    },
                    child: GradientContainer(
                        height: 5.h(
                            context), // not used; padding of parent  container sets the height and width
                        width: 100, // not used
                        text: "New Project",
                        textSize: buttonTextSize,
                        fontWeight: FontWeight.w600,
                        gradient1: red,
                        gradient2: pink,
                        neonGlow: pink,
                        borderColor: tran,
                        borderRadius: 25.w(context)),
                  ),
                ),
              ),
            ));
  }
}
