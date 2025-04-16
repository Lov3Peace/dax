import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';

// import 'package:size_setter/size_setter.dart';
//
class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Container(
            //   color: red,
            //   width: MediaQuery.of(context).size.width * 0.5,
            //   height: MediaQuery.of(context).size.height * 0.5,
            // ),
            // Container(
            //   color: pink,
            //   width: MediaQuery.of(context).size.width * 0.5,
            //   height: MediaQuery.of(context).size.height * 0.5,
            // ),
            Container(
              color: red,
              width: 50.w(context),
              height: 50.h(context),
            ),
            Container(
              color: pink,
              width: 50.w(context),
              height: 50.h(context),
            ),
          ],
        ),
      ),
    );
  }
}
