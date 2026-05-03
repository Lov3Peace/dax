import 'dart:ui';
import 'package:flutter_application_1/util/imports.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../../../util/ui/gradient_label.dart';
import '../../../../../util/ui/tactile_button.dart';
import '../../../desk_decks.dart';
import 'desk_wallet_sections/desk_wallet_c1.dart';
import 'desk_wallet_sections/desk_wallet_c2.dart';
import 'desk_wallet_sections/wallet_templates.dart';

Control slideWallet = Control.stop;

// WalletPopUp
//
// Core wallet interface container.
//
// Responsibilities:
// - Hosts the full wallet experience (balance + actions + settings)
// - Combines transactional UI (left) + account data (right)
// - Acts as a modal-style overlay with glassmorphism design
//
// Layout Strategy:
// - Left side → transactional flow (send / deposit / transfer)
// - Right side → wallet info (WalletC1 + WalletC2)
class WalletPopUp extends StatefulWidget {
  const WalletPopUp({super.key});

  @override
  State<WalletPopUp> createState() => WalletPopUpState();
}

// GLOBAL CONTROLLERS (problematic)
// These are currently outside widget scope → shared across entire app lifecycle
// Should eventually be moved into state management (Provider/Riverpod)
final amountController = TextEditingController();
final TextEditingController cardController = TextEditingController();
final TextEditingController locationController = TextEditingController();

// Mock data (should come from backend / user profile)
final List<String> linkedCards = [
  'Visa **** 1234',
  'Chase Debit **** 5678',
  'Cash App Card',
];

// Destinations (currently same as cards — placeholder)
final List<String> locations = [
  'Visa **** 1234',
  'Chase Debit **** 5678',
  'Cash App Card',
];

// Transaction frequency options
final List<String> frequency = [
  'Once',
  'Weekly',
  'BiWeekly',
  'Monthly',
];

class WalletPopUpState extends State<WalletPopUp> with AnimationMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h(context),
      width: 71.w(context),
      alignment: Alignment.center,

      // Stack allows layering (background + main card)
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 77.h(context),
            width: 65.w(context),

            /// Main glass container
            child: Material(
              shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
              color: const Color.fromARGB(140, 20, 20, 30),
              elevation: 2,
              borderRadius: BorderRadius.circular(32),
              child: Stack(children: [
                /// Background blur effect (glassmorphism)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: deckBorderColor),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),

                // Main content
                Padding(
                  padding: EdgeInsets.only(
                    right: 2.h(context),
                    left: 2.h(context),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 1.w(context),
                        children: [
                          // LEFT SIDE (TRANSACTIONS)
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              // TRANSACTION PANEL
                              Padding(
                                padding: EdgeInsets.only(top: 19.h(context)),
                                child: Container(
                                  height: 55.h(context),
                                  width: 29.w(context),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(70, 32, 32, 40),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.w(context)),

                                    // Scrollable form inputs
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Action selector (Transfer / Deposit / Send)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 4.h(context)),
                                            child: const SelectableTactile(),
                                          ),

                                          SizedBox(height: 2.h(context)),

                                          // FROM (card selection)
                                          Text('From',
                                              style: _sectionStyle(context)),
                                          SizedBox(height: 1.h(context)),

                                          LinkedCardDropdownField(
                                            cards: linkedCards,
                                            controller: cardController,
                                            label: 'Choose a Card',
                                          ),

                                          SizedBox(height: 2.h(context)),

                                          // DESTINATION
                                          Text('Destination',
                                              style: _sectionStyle(context)),
                                          SizedBox(height: 1.h(context)),

                                          LinkedCardDropdownField(
                                            cards: locations,
                                            controller: locationController,
                                            label: 'Choose a Destination',
                                          ),

                                          SizedBox(height: 2.h(context)),

                                          // AMOUNT + FREQUENCY

                                          Center(
                                            child: Wrap(
                                              spacing: 1.w(context),
                                              alignment: WrapAlignment.center,
                                              children: [
                                                // Amount input
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 1.h(context)),
                                                      child: Text(
                                                        'Amount',
                                                        style: _sectionStyle(
                                                            context),
                                                      ),
                                                    ),
                                                    CustomSizedTextField(
                                                      controller:
                                                          amountController,
                                                      width: 12.w(context),
                                                    )
                                                  ],
                                                ),

                                                // Frequency selection
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 1.h(context)),
                                                      child: Text(
                                                        'Frequency',
                                                        style: _sectionStyle(
                                                            context),
                                                      ),
                                                    ),
                                                    LinkedCardDropdownField(
                                                      cards: frequency,
                                                      controller:
                                                          locationController,
                                                      width: 12.w(context),
                                                      label: 'Select',
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 3.h(context)),

                                          // SUBMIT BUTTON
                                          // Executes transaction (not wired yet)
                                          Center(
                                            child: TactileButton(
                                              onTap: () {
                                                /// TODO:
                                                /// - Validate inputs
                                                /// - Trigger transaction logic
                                                /// - Connect to backend
                                              },
                                              child: GradientContainer(
                                                gradient1: blue,
                                                gradient2: const Color.fromARGB(
                                                    255, 85, 221, 89),
                                                height: 2.h(context),
                                                width: 15.h(context),
                                                neonGlow: greenGlow,
                                                text: 'Submit',
                                                textSize: 3.sp(context),
                                                borderColor: Colors.white38,
                                                borderRadius: 500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // BALANCE CARD (TOP)

                              Padding(
                                padding: EdgeInsets.only(top: 2.h(context)),
                                child: Container(
                                  height: 20.h(context),
                                  width: 20.w(context),

                                  /// Gradient + glow for emphasis
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      blue,
                                      Color.fromARGB(255, 85, 221, 89)
                                    ]),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: blue,
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.solid,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(24),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),

                                    // Non-scrollable display card
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Header (Balance + user tag)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.5.w(context)),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Balance',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 5.sp(context),
                                                    ),
                                                  ),

                                                  // Hardcoded username: needs to be dynamic
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          1.h(context)),
                                                      child: Text(
                                                        "katarina",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              3.sp(context),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Balance value
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 2.h(context),
                                                left: 2.w(context),
                                                top: 5.h(context)),
                                            child: Text(
                                              NumberFormat.simpleCurrency(
                                                      locale: 'en-US',
                                                      decimalDigits: 2)
                                                  .format(7837),

                                              /// Hardcoded balance
                                              style: TextStyle(
                                                fontSize: 3.sp(context),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // RIGHT SIDE (WALLET DATA)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h(context)),
                            child: Container(
                              height: 74.h(context),
                              width: 32.w(context),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(0, 194, 36, 36),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),

                              // Holds WalletC1 + WalletC2 (modular components)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const WalletC1(),
                                  WalletC2(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Shared text style for section headers
  TextStyle _sectionStyle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 3.sp(context),
    );
  }
}
