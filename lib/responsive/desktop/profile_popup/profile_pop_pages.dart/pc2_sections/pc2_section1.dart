import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../../../util/providers/userProvider.dart';
import '../../../desk_decks.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/util/providers/profileSocketIoProvider.dart';

/// Profile Card 2 Section1 - Profile bio and skills editor
///
/// Displays the first profile section for user-generated personal details,
/// including a bio input and skills selection area. This widget manages
/// local state and persists user-entered data with SharedPreferences
/// for simple on-device storage between sessions.

class Pc2Section1 extends StatefulWidget {
  const Pc2Section1({super.key});

  @override
  State<Pc2Section1> createState() => _Pc2Section1State();
}

class _Pc2Section1State extends State<Pc2Section1> {
  final bioController = TextEditingController();
  final bioFocus = FocusNode();

  String loadedUsername = '';

  @override
  void initState() {
    super.initState();

    bioFocus.addListener(() {
      if (!bioFocus.hasFocus) {
        saveBio();
      }
    });
  }

  void saveBio() {
    final profile = context.read<ProfileProvider>().profile;
    final username = context.read<UserProvider>().username;

    if (username.isNotEmpty &&
        username == profile?['username'] &&
        bioController.text != (profile?['profile']?['bio'] ?? '')) {
      context.read<ProfileProvider>().updateUserBio(
            bioController.text,
          );
    }
  }

  @override
  void dispose() {
    bioFocus.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

    final bio = profile?['profile']?['bio'] ?? '';
    final username = profile?['username'] ?? '';

    if (loadedUsername != username) {
      loadedUsername = username;
      bioController.text = bio;
    }

    final skills = List<String>.from(
      profile?['skills'] ?? [],
    );

    final loggedInUsername = context.watch<UserProvider>().username;

    final isOwner = loggedInUsername.isNotEmpty && loggedInUsername == username;

    return CarouselContentsTemp(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildBio(context, bio, isOwner),
            SizedBox(height: 1.h(context)),
            buildSkills(context, skills),
          ],
        ),
      ),
    );
  }

  Widget buildBio(BuildContext context, String bio, bool isOwner) {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bio',
                style: TextStyle(
                  fontSize: 5.sp(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              isOwner
                  ? TextField(
                      controller: bioController,
                      focusNode: bioFocus,
                      style: TextStyle(
                        fontSize: 2.5.sp(context),
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Tell Us About Yourself!',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      onTapOutside: (_) => bioFocus.unfocus(),
                    )
                  : Text(
                      bio.isEmpty ? 'No bio added yet.' : bio,
                      style: TextStyle(
                        fontSize: 2.5.sp(context),
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkills(BuildContext context, List<String> skills) {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: BorderRadius.circular(40),
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
                fontSize: 5.sp(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h(context)),
            ...skills.map(
              (skill) => Text(
                skill,
                style: TextStyle(
                  fontSize: 2.5.sp(context),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
