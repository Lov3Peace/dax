import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../pages/main.dart';
import '../../responsive/mobile/mob_constants.dart';
import '../../responsive/mobile/mobile_dashboard.dart';
import '../Personal SignIn/per_sign_in_form.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    super.key,
  });

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
                  prefixIcon: SvgPicture.asset(
                    "",
                  ),
                  prefixIconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  //fillColor: Colors.white54,
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
                  prefixIcon: SvgPicture.asset(
                    "",
                  ),
                  prefixIconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  //fillColor: Colors.white54,
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
                  prefixIcon: SvgPicture.asset(
                    "",
                  ),
                  prefixIconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  //fillColor: Colors.white54,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SignInButton(
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
