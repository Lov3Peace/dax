import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletC1 extends StatelessWidget {
  WalletC1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: .5.h),
      child: Container(
        height: 36.h,
        width: 33.w,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 39, 38, 38),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 2.w,
            right: 2.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              //
              // Wallet address
              const Text(
                'Wallet Address',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Row(
                children: [
                  const Text(
                    'xxxx-4321',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  ElevatedButton(
                    //style: ButtonStyle(backgroundColor:Colors.white10),
                    onPressed: () {},
                    child: const Text('View'),
                  ),
                ],
              ),

              //
              //
              // Divids Wallet address and Project contributions
              const Divider(
                color: Colors.grey,
                indent: 0,
                endIndent: 0,
              ),

              //
              //
              // Project contribution section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Project Contributions',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lagom Mini',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'en-US', decimalDigits: 2)
                              .format(374),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Niche Zero',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'en-US', decimalDigits: 2)
                              .format(550),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //
              //
              // Divids the project contribution and deposits section

              const Divider(
                color: Colors.grey,
                indent: 0,
                endIndent: 0,
              ),

              //
              //
              // Deposits section on the wallet
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Deposits',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2.5.h,
                      bottom: 1.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Wallet',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'en-US', decimalDigits: 2)
                              .format(10000),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
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
    );
  }
}
