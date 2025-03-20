import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/help/help_side_panel.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../desk_constants.dart';
import '../../../desk_decks.dart';
import 'help_side_panel_info/help_faqs_button.dart';

// Popup to the FAQs button of the dashboard side panel
class HelpPopUp extends StatelessWidget {
  const HelpPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) {
        return Container(
          height: 100.h(context),
          width: 71.w(context),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 77.h(context),
                width: 71.w(context),
                // padding: const EdgeInsets.symmetric(vertical: 32),
                child: Material(
                  shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                  color: const Color.fromARGB(140, 20, 20, 30),
                  elevation: 2,
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                              // height: 85.h(context),
                              decoration: BoxDecoration(
                            border: Border.all(color: deckBorderColor),
                            borderRadius: BorderRadius.circular(24),
                          )),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: .7.h(context), bottom: .7.h(context)),
                            child: Wrap(
                              spacing: 1.w(context),
                              children: [
                                // This column houses the title of the popup along with the container
                                // that houses the class infosidepanel
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: .5.h(context)),
                                      child: const Text(
                                        'FAQs',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 68.h(context),
                                      width: 14.w(context),
                                      constraints: const BoxConstraints(maxWidth: 500, minHeight: 250),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(17, 17, 17, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2.h(context)),
                                        child: const Column(
                                          children: [
                                            FAQsSidePanel(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // This container houses the container that holds the information for the specified button selected
                                // in the faqs side panel.
                                Container(
                                  height: 75.h(context),
                                  width: 50.w(context),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(17, 17, 17, 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    // The container that holds the information
                                    child: Container(
                                      height: 71.h(context),
                                      width: 48.w(context),
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(15, 15, 17, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: const FAQsInformation(),
                                    ),
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
            ],
          ),
        );
      },
    );
  }
}
