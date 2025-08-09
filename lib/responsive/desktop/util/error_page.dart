import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebUiTemplate(
        child: Center(
          child: Text(
            'Error: Page Not Found',
            style: GoogleFonts.montserrat(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
                Shadow(color: pink, blurRadius: 1),
                Shadow(color: red, blurRadius: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
