import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

// The class the holds the information in the access settings button
// note: There is much editing that needs to happen in these section but ultimately
// Ui must be created and better refined

class AccessSettingsInfo extends StatefulWidget {
  AccessSettingsInfo({super.key});

  @override
  State<AccessSettingsInfo> createState() => AccessSettingsInfoState();
}

class AccessSettingsInfoState extends State<AccessSettingsInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h(context),
      width: 47.w(context),
      decoration: const BoxDecoration(
        color: Color.fromARGB(70, 32, 32, 40),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(1.h(context)),
              child: Text(
                'Accessibility Settings',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 7.sp(context)),
              ),
            ),

            // Container #1 which holds the Username access
            Center(
              child: Container(
                height: 16.h(context),
                width: 43.w(context),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(25, 25, 29, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h(context),
            ),
            // Container #2
            Center(
              child: Container(
                height: 16.h(context),
                width: 43.w(context),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(25, 25, 29, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h(context),
            ),
            //Container #3
            Center(
              child: Container(
                height: 40.h(context),
                width: 43.w(context),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(25, 25, 29, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h(context),
            ),
          ],
        ),
      ),
    );
  }
}
