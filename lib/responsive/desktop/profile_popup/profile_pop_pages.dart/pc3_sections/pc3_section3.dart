import 'package:flutter/material.dart';

import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import '../../../../../util/gradient_label.dart';
import '../../../../../util/tactile_button.dart';

class Pc3Section3 extends StatefulWidget {
  Pc3Section3({super.key});

  @override
  State<Pc3Section3> createState() => _Pc3Section3State();
}

class _Pc3Section3State extends State<Pc3Section3> {
  final cardController = TextEditingController();
  final paypalController = TextEditingController();

  final paypalEnabled = ValueNotifier(false);

  final messagesEnabled = ValueNotifier(false);
  final friendRequestsEnabled = ValueNotifier(false);
  final transactionsEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      messagesEnabled.value = prefs.getBool('messagesEnabled') ?? false;
      friendRequestsEnabled.value = prefs.getBool('friendRequestsEnabled') ?? false;
      transactionsEnabled.value = prefs.getBool('transactionsEnabled') ?? false;
      paypalEnabled.value = prefs.getBool('paypalEnabled') ?? false;
    });
  }

  Future<void> savePreference(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  void updatePaypal() {
    savePreference('Paypal', paypalController.text);
    showSnackBar('Paypal Account updated!');
  }

  void updateCard() {
    savePreference('Card', cardController.text);
    showSnackBar('Card Number updated!');
  }

  // Function to reset the password
  void resetPassword(BuildContext context) {
    // showSnackBar(context, 'Password reset! New password: NewPassword123');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNotifications(),
          buildBilling(),
        ],
      ),
    );
  }

  Widget buildNotifications() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: TextStyle(fontSize: 4.sp(context), fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: TextStyle(fontSize: 3.sp(context)),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: messagesEnabled,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: .75,
                        child: Switch(
                          value: value,
                          onChanged: (bool newValue) {
                            messagesEnabled.value = newValue;
                            // savePaypalPreference(newValue);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Friend Requests',
                    style: TextStyle(fontSize: 3.sp(context)),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: friendRequestsEnabled,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: .75,
                        child: Switch(
                          value: value,
                          onChanged: (bool newValue) {
                            friendRequestsEnabled.value = newValue;
                            // _savePaypalPreference(newValue);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(fontSize: 3.sp(context)),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: transactionsEnabled,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: .75,
                        child: Switch(
                          value: value,
                          onChanged: (bool newValue) {
                            transactionsEnabled.value = newValue;
                            // _savePaypalPreference(newValue);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBilling() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing',
                style: TextStyle(fontSize: 4.sp(context), fontWeight: FontWeight.bold),
              ),

              // First Row: Card Number and Edit Button
              buildBillingContent('Card Number', cardController, updateCard),

              // Second Row: Paypal and Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PayPal',
                    style: TextStyle(fontSize: 3.sp(context)),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: paypalEnabled,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: .75,
                        child: Switch(
                          value: value,
                          onChanged: (bool newValue) {
                            paypalEnabled.value = newValue;
                            // _savePaypalPreference(newValue);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Third Row: Paypal Account and Edit Button
              buildBillingContent('Paypal Account', paypalController, updatePaypal)
            ],
          ),
        ),
      ),
    );
  }

  buildBillingContent(
    String hintText,
    TextEditingController controller,
    VoidCallback onUpdate,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 10),
        TactileButton(
          onTap: onUpdate,
          child: GradientContainer(
            gradient1: Colors.red,
            gradient2: purp,
            height: 5,
            width: 15,
            neonGlow: red,
            text: 'Update',
            textSize: 2.sp(context),
            borderColor: Colors.transparent,
            borderRadius: 500,
          ),
        ),
      ],
    );
  }
}
