import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../pages/main.dart';
import '../../../mobile/mob_constants.dart';
import '../../../mobile/mobile_dashboard.dart';
import '../SignIn/tab_signin_form.dart';
import '../tab_final_signin.dart';

class TabSignUpForm extends StatefulWidget {
  TabSignUpForm({
    super.key,
  });

  @override
  State<TabSignUpForm> createState() => _TabSignUpFormState();
}

class _TabSignUpFormState extends State<TabSignUpForm> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(
              "Username",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Text(
              "Password",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Remember Me",
                ),
                Switch(
                    value: isSwitch,
                    activeColor: Colors.white,
                    activeTrackColor: Color.fromARGB(255, 221, 83, 245),
                    onChanged: (bool newBool) {
                      setState(() {
                        isSwitch = newBool;
                      });
                    }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TabSignButton(
              onTap: signinbtn,
            ),
            // Text(
            //   "Password",
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0, bottom: 16),
            //   child: TextFormField(
            //     obscureText: true,
            //     decoration: InputDecoration(
            //       prefixIcon: SvgPicture.asset(
            //         "images/Lock.svg",
            //       ),
            //       prefixIconColor: Colors.white,
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(
            //           screenWidth / 4,
            //         ),
            //         borderSide:
            //             BorderSide(color: Color.fromARGB(160, 41, 41, 41)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void signinbtn() {}
}
