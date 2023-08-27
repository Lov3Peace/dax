import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/responsive/desktop/desktop_constants.dart';
import 'package:flutter_application_1/util/Window%20Route/wallet_window_route.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class WalletWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const WalletWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(WalletWindowRoute(builder: (context) {
            return const _WalletWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroWalletWindow,
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.wallet,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroWalletWindow = 'Message-window-hero';

class _WalletWindowPopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const _WalletWindowPopupCard({Key? key}) : super(key: key);

  @override
  State<_WalletWindowPopupCard> createState() => _WalletWindowPopupCardState();
}

class _WalletWindowPopupCardState extends State<_WalletWindowPopupCard> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
            child: Center(
              child: Container(
                height: 85.h,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Hero(
                  tag: _heroWalletWindow,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Material(
                    shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
                    color:
                        const Color.fromARGB(42, 55, 52, 52).withOpacity(0.7),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                                height: 85.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          182, 31, 31, 31)),
                                  borderRadius: BorderRadius.circular(24),
                                )),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 55.w, top: 1.h),
                                child: const Text(
                                  "Wallet",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),

                              //Container for the Card itself
                              Container(
                                margin: EdgeInsets.all(1.75.h),
                                height: 23.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    blue,
                                    Color.fromARGB(255, 85, 221, 89),
                                  ]),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: blue,
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.solid)
                                  ],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Row for Balance and Profile bubble
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.w, right: 2.w),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                const Text(
                                                  'Balance',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                            0, 86, 81, 81)
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 1.h,
                                                      right: 5.w,
                                                      left: 5.w,
                                                      bottom: 1.h,
                                                    ),
                                                    child: const Text(
                                                      "s3rv",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        //Money for card
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 2.h,
                                            left: 2.w,
                                            top: 10.h,
                                          ),
                                          child: Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'en-US',
                                                    decimalDigits: 2)
                                                .format(7837),
                                            style: const TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Row of buttons for Wallet
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      //Send Button for Wallet
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [blue, blue]),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: blue,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Text(
                                            "Send",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      //Deposit Button for Wallet
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 1.5.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  blue,
                                                  Color.fromARGB(
                                                      255, 85, 221, 89),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: blue,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Text(
                                            "Deposit",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Transfer Button for Wallet
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 1.h),
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 85, 221, 89),
                                                  Color.fromARGB(
                                                      255, 85, 221, 89),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: greenGlow,
                                                    blurRadius: 3,
                                                    blurStyle: BlurStyle.solid)
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Text(
                                            "Transfer",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //Container housing the financial data for Account
                              Container(
                                margin: EdgeInsets.all(1.75.h),
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 39, 38, 38),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Linked Card Container Text
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              bottom: 1.h,
                                              left: 5.w,
                                            ),
                                            child: const Text(
                                              'Linked Card',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: Container(
                                              height: 6.h,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                        159, 28, 28, 28)
                                                    .withOpacity(0.98),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  runAlignment:
                                                      WrapAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.h),
                                                      child: const Text(
                                                          'XXXX-1234',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 3.w,
                                                              vertical: 1.h),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            104, 95, 94, 94),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Project Contribution Container
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 1.h,
                                              left: 5.w,
                                            ),
                                            child: const Text(
                                              'Project Contributions',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: Container(
                                              height: 6.h,
                                              margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                        159, 28, 28, 28)
                                                    .withOpacity(0.98),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  runAlignment:
                                                      WrapAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.h),
                                                      child: const Text(
                                                          'Lagom Mini',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 3.w,
                                                              vertical: 1.h),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            104, 95, 94, 94),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                      child: Text(
                                                        NumberFormat
                                                            .simpleCurrency(
                                                          locale: 'en-US',
                                                        ).format(374),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //Deposits Container
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 1.h,
                                              left: 5.w,
                                            ),
                                            child: const Text(
                                              'Deposits',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: Container(
                                              height: 6.h,
                                              margin:
                                                  EdgeInsets.only(bottom: 1.h),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                        159, 28, 28, 28)
                                                    .withOpacity(0.98),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  runAlignment:
                                                      WrapAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.h),
                                                      child: const Text(
                                                          'Wallet',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 3.w,
                                                              vertical: 1.h),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            104, 95, 94, 94),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                      child: Text(
                                                        NumberFormat
                                                            .simpleCurrency(
                                                          locale: 'en-US',
                                                        ).format(10000),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255, 85, 221, 89),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
