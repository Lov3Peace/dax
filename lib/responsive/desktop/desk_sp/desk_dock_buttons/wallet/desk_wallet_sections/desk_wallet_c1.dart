import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:intl/intl.dart';
import '../../../../../../util/gradient_container.dart';
import '../../../../../../util/tactile_button.dart';

class WalletC1 extends StatelessWidget {
  WalletC1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.5.h(context)),
      child: Container(
        height: 35.h(context),
        width: 33.w(context),
        decoration: const BoxDecoration(
          color: Color.fromARGB(70, 32, 32, 40),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w(context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h(context)),

                // Wallet Address
                Text(
                  'Wallet Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.sp(context),
                  ),
                ),
                SizedBox(height: 1.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'xxxx-4321',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.sp(context),
                      ),
                    ),
                    TactileButton(
                      onTap: () {},
                      child: GradientContainer(
                        gradient1: blue,
                        gradient2: const Color.fromARGB(255, 85, 221, 89),
                        height: 1.h(context),
                        width: 2.h(context),
                        neonGlow: greenGlow,
                        text: 'View',
                        textSize: 2.sp(context),
                        borderColor: Colors.white38,
                        borderRadius: 500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h(context)),
                const Divider(color: Colors.grey),

                // Project Contributions
                SizedBox(height: 1.h(context)),
                Text(
                  'Project Contributions',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.sp(context),
                  ),
                ),
                SizedBox(height: 1.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lagom Mini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'en-US').format(374),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Niche Zero',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'en-US').format(550),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h(context)),
                const Divider(color: Colors.grey),

                SizedBox(height: 1.h(context)),

                //Deposits
                Text(
                  'Deposits',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.sp(context),
                  ),
                ),
                SizedBox(height: 2.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.sp(context),
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'en-US').format(10000),
                      style: TextStyle(
                        fontSize: 2.sp(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Omega Project',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.sp(context),
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'en-US').format(100000),
                      style: TextStyle(
                        fontSize: 2.sp(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
