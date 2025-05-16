import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

// This class houses the about us information for the given button
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader('Term & Conditions', context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Mission',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Origin',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Founders',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
          ],
        ),
      ),
    );
  }

// This builds the header for the page called by a specific button
// on the info side panel
  Widget buildHeader(String title, context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h(context), left: 3.w(context)),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 6.sp(context),
        ),
      ),
    );
  }

// this build displays the sections pertaining to teh specific header
  Widget buildSection(String title, String content, context) {
    return Container(
      height: 24.h(context),
      width: 45.w(context),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 0.233),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 3.w(context), top: 1.h(context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Padding(
                padding: EdgeInsets.only(top: 2.5.h(context), right: 1.5.w(context)),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 3.sp(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
