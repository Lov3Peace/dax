import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

// this class houses all the information for the faqs button
class SocialsInformation extends StatelessWidget {
  const SocialsInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.5.h(context),
      width: 48.w(context),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader('Socials', context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Q: How can I go hawda?',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Q: Is going hawda mandatory?',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            buildSection(
                'Q: Will Lex ever go hawda?',
                'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum.',
                context),
          ],
        ),
      ),
    );
  }

// This build gives the header of the section selected
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

// This build the sections for the specified faqs button
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
