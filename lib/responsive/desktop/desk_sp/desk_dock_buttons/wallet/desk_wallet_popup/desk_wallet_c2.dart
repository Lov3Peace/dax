import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletC2 extends StatefulWidget {
  WalletC2({super.key});

  @override
  State<WalletC2> createState() => _WalletC2State();
}

class _WalletC2State extends State<WalletC2> {
  bool _isEditable = false;

  bool _isHidden = true;

  bool isSwitch = false;

  bool isSwitch2 = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
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
            top: .5.h,
            right: 2.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Wallet Address
              //This will be where the user wallet is linked too on the app/website
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controller,
                          enabled: _isEditable,
                          obscureText: _isHidden,
                          decoration: const InputDecoration(
                            labelText: 'Linked Card',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditable = !_isEditable;
                          });
                        },
                        child: Text(_isEditable ? 'Save' : 'Edit'),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        child: Text(_isHidden ? 'Show' : 'Hide'),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                indent: 0,
                endIndent: 0,
              ),
              //
              //
              // Securiy and privacy section
              //this section houses the mulitfactor authentication switch and the blur info switch

              const Text(
                'Security & Privacy',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Column(
                children: [
                  //
                  //
                  // Multifactor Authentication
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Multifactor Authenticaation',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Switch(
                        value: isSwitch,
                        activeColor: Colors.white,
                        activeTrackColor:
                            const Color.fromARGB(255, 221, 83, 245),
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch = newBool;
                          });
                        },
                      ),
                    ],
                  ),
                  //
                  //
                  //Blur Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Blur Info On Load',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Switch(
                        value: isSwitch2,
                        activeColor: Colors.white,
                        activeTrackColor:
                            const Color.fromARGB(255, 221, 83, 245),
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch2 = newBool;
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Statements',
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
                            CurrentMonthText(),
                            ElevatedButton(
                              //style: ButtonStyle(backgroundColor:Colors.white10),
                              onPressed: () {},
                              child: const Text('View'),
                            ),
                          ],
                        ),
                      ),
                    ],
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

// This will be the class that initializes the current month that we are in
// thus showing the staments for the current month
// both purchases and contributions.
class CurrentMonthText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // List of month names
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Get the current month name
    String currentMonth = months[now.month - 1];

    int currentYear = now.year;

    return Text(
      '$currentMonth $currentYear',
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }
}
