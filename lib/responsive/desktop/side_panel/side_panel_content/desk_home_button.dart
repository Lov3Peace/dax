import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/desk_dashboard.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/browser_client.dart' as httpClient;

class DeskHomeButton extends StatefulWidget {
  const DeskHomeButton({super.key});

  @override
  State<DeskHomeButton> createState() => _DeskHomeButtonState();
}

class _DeskHomeButtonState extends State<DeskHomeButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHover = true;
          // print(isHover);
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
          // print(isHover);
        });
      },
      child: GestureDetector(
        onTap: () {
          // loginCheck();
          router.go("/");
        },
        child: Stack(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [red, pink]),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  width: isHover ? 10.w(context) : 0.25.w(context),
                  height: 7.sp(context),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    // color: blue,
                    height: 7.sp(context),
                  ),
                ),
              ],
            ),
            // Since they're not in a row, have to use Positioned. This allows
            // the animated container to pass under the icon
            Positioned(
              top: 1.sp(context),
              left: 0.5.w(context),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w(context)),
                    child: Icon(
                      Icons.dashboard_rounded,
                      size: 5.sp(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w(context)),
                    child: Text(
                      'Home',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(fontSize: 2.sp(context)),
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future loginCheck() async {
  //   final client = httpClient.BrowserClient()..withCredentials = true;
  //   final loginCheckEndpoint =
  //       Uri.parse('http://127.0.0.1/api/loginCheck');
  //   var res = await client
  //       .get(loginCheckEndpoint, headers: {"Content-Type": "application/json"});
  //   return res;
  // }
}
