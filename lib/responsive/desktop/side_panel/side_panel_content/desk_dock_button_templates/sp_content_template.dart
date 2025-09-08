import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class SpContentPanel extends StatelessWidget {
  final String headerTitle;
  final List<InfoSection> sections;
  final double panelHeight;
  final double panelWidth;
  final double sectionHeight;
  final double sectionWidth;

  const SpContentPanel({
    super.key,
    required this.headerTitle,
    required this.sections,
    this.panelHeight = 72.5,
    this.panelWidth = 48,
    this.sectionHeight = 24,
    this.sectionWidth = 45,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: panelHeight.h(context),
      width: panelWidth.w(context),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(headerTitle, context),
            const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            for (var section in sections) ...[
              buildSection(section.title, section.content, context),
              const Divider(color: Colors.grey, indent: 20, endIndent: 30),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildHeader(String title, BuildContext context) {
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

  Widget buildSection(String title, String content, BuildContext context) {
    return Container(
      height: sectionHeight.h(context),
      width: sectionWidth.w(context),
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
              Text(title,
                  style: TextStyle(
                      color: Colors.white, fontSize: 3.5.sp(context))),
              Padding(
                padding:
                    EdgeInsets.only(top: 2.5.h(context), right: 1.5.w(context)),
                child: Text(
                  content,
                  style:
                      TextStyle(fontSize: 3.sp(context), color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoSection {
  final String title;
  final String content;

  InfoSection({required this.title, required this.content});
}
