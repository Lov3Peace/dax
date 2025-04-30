import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_sp/desk_dock_buttons/wallet/field_dropdown.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../../../util/gradient_label.dart';
import '../../../../../util/tactile_button.dart';

import '../../../desk_decks.dart';
import 'desk_wallet_sections/desk_wallet_c1.dart';
import 'desk_wallet_sections/desk_wallet_c2.dart';
import 'test_tactilebutton.dart';

Control slideWallet = Control.stop;

class WalletPopUp extends StatefulWidget {
  const WalletPopUp({super.key});

  @override
  State<WalletPopUp> createState() => WalletPopUpState();
}

final amountController = TextEditingController();

final TextEditingController cardController = TextEditingController();
final TextEditingController locationController = TextEditingController();
// consists of all linked cards to the account
final List<String> linkedCards = [
  'Visa **** 1234',
  'Chase Debit **** 5678',
  'Cash App Card',
];
// can will be auto populaed depending on the destinatuons and contacts within the account
final List<String> locations = [
  'Visa **** 1234',
  'Chase Debit **** 5678',
  'Cash App Card',
];
// the frequency of transaction
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              height: 77.h(context),
              width: 65.w(context),
              // padding: const EdgeInsets.symmetric(vertical: 32),
              child: Material(
                  shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                  color: const Color.fromARGB(140, 20, 20, 30),
                  elevation: 2,
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(children: [
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
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  // This container below houses the pay function of the app
                                  // meaning how you are able to pay other people on projects that you want to particpate in
                                  // or send money to friends as donations as well.
                                  Padding(
                                    padding: EdgeInsets.only(top: 19.h(context)),
                                    child: Container(
                                      height: 55.h(context),
                                      width: 29.w(context),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(70, 32, 32, 40),
                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          1.w(context),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 4.h(context)),
                                                child: const SelectableTactile(),
                                              ),
                                              SizedBox(
                                                height: 2.h(context),
                                              ),
                                              Text(
                                                'From',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.sp(context),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h(context),
                                              ),
                                              LinkedCardDropdownField(
                                                cards: linkedCards,
                                                controller: cardController,
                                                label: 'Choose a Card',
                                              ),
                                              SizedBox(
                                                height: 2.h(context),
                                              ),
                                              Text(
                                                'Destination',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.sp(context),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h(context),
                                              ),
                                              LinkedCardDropdownField(
                                                cards: locations,
                                                controller: locationController,
                                                label: 'Choose a Destination',
                                              ),
                                              SizedBox(
                                                height: 2.h(context),
                                              ),
                                              Center(
                                                child: Wrap(
                                                  spacing: 1.w(context),
                                                  alignment: WrapAlignment.center,
                                                  children: [
                                                    // this column holds the amount given
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: 1.h(context)),
                                                          child: Text(
                                                            'Amount',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 3.sp(context),
                                                            ),
                                                          ),
                                                        ),
                                                        CustomSizedTextField(
                                                          controller: amountController,
                                                          width: 12.w(context),
                                                        )
                                                      ],
                                                    ),
                                                    // this column will holds the reason for sending
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: 1.h(context)),
                                                          child: Text(
                                                            'Frequency',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 3.sp(context),
                                                            ),
                                                          ),
                                                        ),
                                                        LinkedCardDropdownField(
                                                          cards: frequency,
                                                          controller: locationController,
                                                          width: 12.w(context),
                                                          label: 'Select',
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h(context),
                                              ),
                                              //
                                              // Tactile button below will be the means of the user depositing money and seeing money in there account.
                                              // This button will have a on tap function that will allow them to pull from there card or bank account
                                              // referenced in there wallet.
                                              Center(
                                                child: TactileButton(
                                                  onTap: () {},
                                                  child: GradientContainer(
                                                    gradient1: blue,
                                                    gradient2: const Color.fromARGB(255, 85, 221, 89),
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
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h(context)),
                                    child: Container(
                                      height: 20.h(context),
                                      width: 20.w(context),
                                      decoration: BoxDecoration(
                                        gradient:
                                            const LinearGradient(colors: [blue, Color.fromARGB(255, 85, 221, 89)]),
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
                                        child: SingleChildScrollView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 0.5.w(context)),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Wrap(
                                                    alignment: WrapAlignment.spaceBetween,
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Balance',
                                                        style: TextStyle(
                                                          color: const Color.fromARGB(255, 255, 255, 255),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 5.sp(context),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: const Color.fromARGB(0, 86, 81, 81).withOpacity(0.6),
                                                          borderRadius: BorderRadius.circular(24),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(1.h(context)),
                                                          child: Text(
                                                            "katarina",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 3.sp(context),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 2.h(context), left: 2.w(context), top: 5.h(context)),
                                                child: Text(
                                                  NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 2)
                                                      .format(7837),
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
                              //
                              // The container below houses two more container that have all stored information pertaining to the wallet.
                              // WalletC1 AKA Wallet Container One houses the stored information such as wallet address,  your project contributions,
                              //and the money you have deposited.
                              // WalletC2 AKA Wallet Container Two houses the stored informations such as Linked Card or bank account, security and privacy aspects,
                              // and mothly statements.
                              Padding(
                                padding: EdgeInsets.only(top: 1.h(context)),
                                child: Container(
                                  height: 74.h(context),
                                  width: 32.w(context),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(0, 194, 36, 36),
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      WalletC1(),
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
                  ])))
        ],
      ),
    );
  }
}
