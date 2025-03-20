import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

//Terms & Conditions Information
class TermsConditionsInformation extends StatelessWidget {
  const TermsConditionsInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.5.h(context),
      width: 45.w(context),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
