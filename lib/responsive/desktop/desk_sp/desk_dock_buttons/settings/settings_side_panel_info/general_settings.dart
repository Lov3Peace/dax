import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/firebase_tools/username_change.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

// The class the holds the information in the genral settings button
// note: There is much editing that needs to happen in these section but ultimately
// Ui must be created and better refined
class GeneralSettingsInfo extends StatefulWidget {
  GeneralSettingsInfo({super.key});

  @override
  State<GeneralSettingsInfo> createState() => _GeneralSettingsInfoState();
}

class _GeneralSettingsInfoState extends State<GeneralSettingsInfo> {
  final TextEditingController controller = TextEditingController();
  final auth = FirebaseAuth.instance;

  bool isEditingEnabled = true;
  bool isHidden = true;
  bool isEditable = false;
  String username = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadUsername(FirebaseAuth.instance.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.username;

    return Container(
      height: 55.h(context),
      width: 47.w(context),
      decoration: const BoxDecoration(
        color: Color.fromARGB(70, 32, 32, 40),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(1.h(context)),
              child: Text(
                'General Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp(context)),
              ),
            ),

            // Container #1 which holds the Username access
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 16.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.h(context), vertical: 2.h(context)),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Username:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 5.sp(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 1.w(context),
                            ),
                            Expanded(
                              child: isEditable
                                  ? TextField(
                                      controller: controller,
                                      enabled: isEditable,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle: const TextStyle(
                                            color: Colors.white70),
                                        filled: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 16),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () => setState(
                                              () => isHidden = !isHidden),
                                          icon: Icon(
                                            isHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      getCurrentUsername(),
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 5.sp(context),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(width: 1.h(context)),
                            TactileButton(
                              onTap: () async {
                                if (isEditable) {
                                  // Save the edited username
                                  final newUsername = controller.text.trim();
                                  if (newUsername.isNotEmpty) {
                                    try {
                                      await auth.currentUser!
                                          .updateDisplayName(newUsername);
                                      await auth.currentUser!
                                          .reload(); // refresh user session
                                      userProvider.updateUsername(newUsername);
                                      debugPrint(
                                          'Username updated to: $username');
                                    } catch (e) {
                                      debugPrint(
                                          'Failed to update username: $e');
                                    }
                                  }
                                } else {
                                  controller.text = username;
                                }
                                setState(() => isEditable = !isEditable);
                              },
                              child: GradientContainer(
                                gradient1:
                                    isEditable ? blue : Colors.transparent,
                                gradient2: isEditable
                                    ? const Color.fromARGB(255, 85, 221, 89)
                                    : Colors.transparent,
                                height: 1.h(context),
                                width: 2.h(context),
                                neonGlow:
                                    isEditable ? greenGlow : Colors.transparent,
                                text: isEditable ? 'Save' : 'Edit',
                                textSize: 2.sp(context),
                                borderColor: Colors.white38,
                                borderRadius: 500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h(context),
                        ),
                        const Divider(
                          color: Colors.grey,
                          // indent: 20,
                          // endIndent: 20,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 1.h(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 2.w(context),
                          ),
                          child: const Text(
                            'Placeholder',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Container #2
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 16.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),

            //Container #3
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 40.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
