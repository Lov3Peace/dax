import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';

class PC1 extends StatelessWidget {
  PC1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h(context),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "images/creator.png",
              height: 38.h(context),
            ),
            Text(
              "Creator",
              style: TextStyle(color: white, fontSize: 5.sp(context), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
