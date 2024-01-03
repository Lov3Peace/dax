import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/GlobalProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sizer/sizer.dart';
import '../../../util/gradient_container.dart';
import '../../../util/tactile_button.dart';

// const String heroWalletWindow = 'Wallet-window-hero';
Control slideWallet = Control.stop;

class WalletPopUp extends StatefulWidget {
  WalletPopUp({super.key});

  State<WalletPopUp> createState() => _WalletPopUpState();
}

final walletIDController = TextEditingController();
final reasonController = TextEditingController();

class _WalletPopUpState extends State<WalletPopUp> with AnimationMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
        builder: (context, value, child) => CustomAnimationBuilder<double>(
              control: value.walletSlideControl,
              startPosition: 0,
              tween: Tween(begin: 0, end: 83.5.w),
              duration: const Duration(milliseconds: 1250),
              curve: Curves.easeInOutBack,
              onCompleted: () {
                final resetSlide = context.read<GlobalProvider>();
                resetSlide.walletResetSlide();
              },
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: child,
                );
              },
              child: Center(
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
                            elevation: 0,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 1.w,
                                        left: 1.w,
                                      ),
                                      child: Wrap(
                                        spacing: 1.5.w,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),

                                                // Container housing card data
                                                child: Container(
                                                  height: 65.h,
                                                  width: 25.w,
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 500,
                                                          minHeight: 250),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 39, 38, 38),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //Transfer Text
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 16.h,
                                                          bottom: 1.h,
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Transfer',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 36),
                                                          ),
                                                        ),
                                                      ),

                                                      //Text for Pay to
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 1.h,
                                                                left: 2.5.w),
                                                        child: const Text(
                                                          'Pay to',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),

                                                      // Pay to Container
                                                      Center(
                                                        child: Container(
                                                          height: 6.h,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 1.h),
                                                          width: 23.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                    159,
                                                                    28,
                                                                    28,
                                                                    28)
                                                                .withOpacity(
                                                                    0.98),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            ),
                                                            border: const Border
                                                                .fromBorderSide(
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          72,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            child: Column(
                                                              children: [
                                                                TextField(
                                                                  controller:
                                                                      walletIDController,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                          border:
                                                                              InputBorder.none),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      //Guiding text for user
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 3.5.h),
                                                        child: const Center(
                                                          child: Text(
                                                            'Please enter the Wallet ID or destination email',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        113,
                                                                        158,
                                                                        158,
                                                                        158),
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ),

                                                      //Column housing Amount and Reason
                                                      Center(
                                                        child: Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .center,
                                                          children: [
                                                            //Column containing "Amount" Container
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              1.h),
                                                                  child:
                                                                      const Text(
                                                                    'Amount',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 6.h,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              1.h),
                                                                  width: 11.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            159,
                                                                            28,
                                                                            28,
                                                                            28)
                                                                        .withOpacity(
                                                                            0.98),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20),
                                                                    ),
                                                                    border: const Border
                                                                        .fromBorderSide(
                                                                      BorderSide(
                                                                          color: Color.fromARGB(
                                                                              72,
                                                                              255,
                                                                              255,
                                                                              255)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            //Column containing "Reason" Container
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          1.w),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            1.h),
                                                                    child:
                                                                        const Text(
                                                                      'Reason',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 6.h,
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            1.h),
                                                                    width: 11.w,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                              159,
                                                                              28,
                                                                              28,
                                                                              28)
                                                                          .withOpacity(
                                                                              0.98),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            20),
                                                                      ),
                                                                      border: const Border
                                                                          .fromBorderSide(
                                                                        BorderSide(
                                                                            color: Color.fromARGB(
                                                                                72,
                                                                                255,
                                                                                255,
                                                                                255)),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          TextField(
                                                                            controller:
                                                                                reasonController,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                            ),
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

                                                      //Row housing Commission and total amount
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.w),
                                                        child: Center(
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              //Commision Display
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 2
                                                                            .w),
                                                                child:
                                                                    const Column(
                                                                  children: [
                                                                    Text(
                                                                        'Commission:'),
                                                                    //Container(),
                                                                  ],
                                                                ),
                                                              ),

                                                              const VerticalDivider(
                                                                width: 100,
                                                                color: Colors
                                                                    .white,
                                                                thickness: 2,
                                                                indent: 50,
                                                              ),

                                                              //Total Display
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 2
                                                                            .w),
                                                                child:
                                                                    const Column(
                                                                  children: [
                                                                    Text(
                                                                        'Total:'),
                                                                    //Container(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      //Send button
                                                      Center(
                                                        child: TactileButton(
                                                          onTap: () {
                                                            final reverseSlide =
                                                                context.read<
                                                                    GlobalProvider>();
                                                            reverseSlide
                                                                .walletReverseSlide();
                                                          },
                                                          child:
                                                              GradientContainer(
                                                            gradient1: blue,
                                                            gradient2:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    85,
                                                                    221,
                                                                    89),
                                                            height: 15,
                                                            width: 150,
                                                            neonGlow: greenGlow,
                                                            text: 'Send',
                                                            textSize: 12,
                                                            borderColor:
                                                                Colors.white38,
                                                            borderRadius: 500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              //Actual Card of User
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 2.h,
                                                ),
                                                child: Container(
                                                  height: 20.h,
                                                  width: 21.w,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          blue,
                                                          Color.fromARGB(
                                                              255, 85, 221, 89),
                                                        ]),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: blue,
                                                          blurRadius: 10,
                                                          blurStyle:
                                                              BlurStyle.solid)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        SingleChildScrollView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: .5.w,
                                                                    right:
                                                                        .5.w),
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  //Text for balance on card
                                                                  const Text(
                                                                    'Balance',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  ),

                                                                  //Container housing User Id
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                        0,
                                                                        86,
                                                                        81,
                                                                        81,
                                                                      ).withOpacity(
                                                                          0.6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            1.h,
                                                                        right:
                                                                            1.w,
                                                                        left:
                                                                            1.w,
                                                                        bottom:
                                                                            1.h,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        "katarina",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: 2.h,
                                                              left: 2.w,
                                                              top: 5.h,
                                                            ),
                                                            child: Text(
                                                              NumberFormat.simpleCurrency(
                                                                      locale:
                                                                          'en-US',
                                                                      decimalDigits:
                                                                          2)
                                                                  .format(7837),
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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

                                          //Container Housing 3 Containers
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 2.h,
                                            ),
                                            child: Container(
                                              height: 73.5.h,
                                              width: 38.w,
                                              constraints: const BoxConstraints(
                                                  maxWidth: 700,
                                                  minHeight: 250),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    0, 201, 58, 58),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //Container #1
                                                    Container(
                                                      height: 27.h,
                                                      width: 38.w,
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 700,
                                                              minHeight: 100),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              blue,
                                                              Color.fromARGB(
                                                                  255,
                                                                  85,
                                                                  221,
                                                                  89),
                                                            ]),
                                                        // boxShadow: const [
                                                        //   BoxShadow(
                                                        //       color: blue,
                                                        //       blurRadius: 10,
                                                        //       blurStyle:
                                                        //           BlurStyle.solid)
                                                        // ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child:
                                                          SingleChildScrollView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            //Balance Text and Deposit Button Wrap
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 2.w,
                                                                right: 2.w,
                                                                top: 3.5.h,
                                                              ),
                                                              child: SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child: Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    //Text for balance on card
                                                                    const Text(
                                                                      'Balance',
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              20),
                                                                    ),

                                                                    //Depsoit Button
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                          0,
                                                                          86,
                                                                          81,
                                                                          81,
                                                                        ).withOpacity(
                                                                            0.6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: 1
                                                                              .h,
                                                                          right:
                                                                              1.w,
                                                                          left:
                                                                              1.w,
                                                                          bottom:
                                                                              1.h,
                                                                        ),
                                                                        child:
                                                                            TactileButton(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              const Text(
                                                                            "+",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            //Card Balance and Withdraw Button Wrap
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 2.w,
                                                                right: 2.w,
                                                                top: 2.h,
                                                              ),
                                                              child: SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child: Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    // Text display for Card balance
                                                                    Text(
                                                                      NumberFormat.simpleCurrency(
                                                                              locale: 'en-US',
                                                                              decimalDigits: 2)
                                                                          .format(7837),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              36,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),

                                                                    //Withdraw Button
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                          0,
                                                                          86,
                                                                          81,
                                                                          81,
                                                                        ).withOpacity(
                                                                            0.6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: 1
                                                                              .h,
                                                                          right:
                                                                              1.w,
                                                                          left:
                                                                              1.w,
                                                                          bottom:
                                                                              1.h,
                                                                        ),
                                                                        child:
                                                                            TactileButton(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              const Text(
                                                                            "-",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            //Review Stream
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 2.w,
                                                                      top: 5.h),
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  //Upward Arrow
                                                                  const Icon(
                                                                    Ionicons
                                                                        .arrow_up_circle_outline,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white70,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1
                                                                            .h),
                                                                    child: Text(
                                                                      NumberFormat.simpleCurrency(
                                                                              locale: 'en-US',
                                                                              decimalDigits: 2)
                                                                          .format(5649),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  ),

                                                                  //Downward Arrow
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 2
                                                                            .w),
                                                                    child:
                                                                        const Icon(
                                                                      Ionicons
                                                                          .arrow_down_circle_outline,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white70,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1
                                                                            .h),
                                                                    child: Text(
                                                                      NumberFormat.simpleCurrency(
                                                                              locale: 'en-US',
                                                                              decimalDigits: 2)
                                                                          .format(268),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    //Container #2
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.5.h),
                                                      child: Container(
                                                        height: 18.h,
                                                        width: 38.w,
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth: 700,
                                                                minHeight: 100),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 39, 38, 38),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(40),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    //Container #3
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.5.h),
                                                      child: Container(
                                                        height: 25.h,
                                                        width: 38.w,
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth: 700,
                                                                minHeight: 100),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 39, 38, 38),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(40),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 2.w,
                                                            top: .5.h,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              //Information Text
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: .5.h,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  'Information:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          36,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              // Wallet ID for user
                                                              TextButton.icon(
                                                                icon:
                                                                    const Icon(
                                                                  Ionicons
                                                                      .wallet_outline,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .white70,
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                label: Text(
                                                                  'Wallet ID:',
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            2.sp),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        255,
                                                                        253,
                                                                        253),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Safety Lock  for 2FA Check
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 1
                                                                            .h),
                                                                child: Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Ionicons
                                                                          .shield_checkmark_outline,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white70,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              1.h),
                                                                      child:
                                                                          Text(
                                                                        '2FA Enabled:',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          textStyle:
                                                                              TextStyle(fontSize: 2.sp),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              253,
                                                                              253),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // LiteRollingSwitch(

                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Key for Card Acces
                                                              //Will also be finger print accessible
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 1
                                                                            .h),
                                                                child: Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Ionicons
                                                                          .lock_closed_outline,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white70,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              1.h),
                                                                      child:
                                                                          Text(
                                                                        'Key:',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          textStyle:
                                                                              TextStyle(fontSize: 2.sp),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              253,
                                                                              253),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    //"Change" tactile button allows for changing of password
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              25.w),
                                                                      child:
                                                                          TactileButton(
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                const Color.fromARGB(159, 28, 28, 28).withOpacity(0.98),
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(40),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Text('Change'),
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
                                                  ],
                                                ),
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
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

//
// Hover aspect of setting button
class DeskWalletButtonHover extends StatefulWidget {
  const DeskWalletButtonHover({super.key});

  @override
  State<DeskWalletButtonHover> createState() => _DeskWalletButtonHoverState();
}

class _DeskWalletButtonHoverState extends State<DeskWalletButtonHover> {
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
              startSlide.walletActivateSlide();
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wallet_outlined,
            color: isActive
                ? Colors.black87
                : (isHover
                    ? Color.fromARGB(241, 255, 255, 255)
                    : Colors.white70),
            size: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: Text(
              'Wallet',
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
            padding: EdgeInsets.only(left: 4.5.w),
            child: Stack(
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  color: isActive
                      ? Colors.white70
                      : isHover
                          ? Color.fromARGB(241, 255, 255, 255)
                          : tran,
                  size: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //
                      //Reverses the popup card
                      final startSlide = context.read<GlobalProvider>();
                      startSlide.walletReverseSlide();
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
