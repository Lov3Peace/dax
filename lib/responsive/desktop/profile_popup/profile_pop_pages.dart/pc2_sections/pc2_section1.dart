import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/ui/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import '../../../desk_decks.dart';

/// Profile Card 2 Section1 - Profile bio and skills editor
///
/// Displays the first profile section for user-generated personal details,
/// including a bio input and skills selection area. This widget manages
/// local state and persists user-entered data with SharedPreferences
/// for simple on-device storage between sessions.

class Pc2Section1 extends StatefulWidget {
  Pc2Section1({super.key});

  @override
  State<Pc2Section1> createState() => Pc2Section1State();
}

class Pc2Section1State extends State<Pc2Section1> {
  TextEditingController bioController = TextEditingController();
  Set<String> selectedSkills = {};

  @override
  void initState() {
    super.initState();

    loadBio();
  }

  Future<void> loadBio() async {
    final prefs = await SharedPreferences.getInstance();
    bioController.text = prefs.getString('user_bio') ?? '';
    setState(() {});
  }

  Future<void> saveBio() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_bio', bioController.text.trim());
  }

  Future<void> loadSelectedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedSkills = prefs.getStringList('selected_skills')?.toSet() ?? {};
    });
  }

  Future<void> saveSelectedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selected_skills', selectedSkills.toList());
  }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildBio(),
            SizedBox(
              height: 1.h(context),
            ),
            buildSkills(),
          ],
        ),
      ),
    );
  }

  buildBio() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(2.h(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bio',
                style: TextStyle(
                    fontSize: 5.sp(context), fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: bioController,
                style:
                    TextStyle(fontSize: 2.5.sp(context), color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Tell Us About Yourself!",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                maxLines: null, // Allows infinite lines
                keyboardType: TextInputType.multiline,
                onChanged: (text) => saveBio(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSkills() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: TextStyle(
                  fontSize: 5.sp(context), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.h(context),
            ),
            TactileButton(
              //             onTap: showSkillsDialog,
              child: GradientContainer(
                gradient1: red,
                gradient2: purp,
                height: 4.h(context),
                width: 7.w(context),
                neonGlow: purp,
                text: 'Select Skills',
                textSize: 2.5.sp(context),
                borderColor: const Color.fromARGB(0, 255, 255, 255),
                borderRadius: 500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
