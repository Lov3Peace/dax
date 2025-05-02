import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../main.dart';
import '../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

class Pc3Section2 extends StatefulWidget {
  Pc3Section2({super.key});

  @override
  State<Pc3Section2> createState() => _Pc3Section2State();
}

class _Pc3Section2State extends State<Pc3Section2> {
  final ValueNotifier<bool> mfaEnabled = ValueNotifier(false);
  final ValueNotifier<bool> privateAccountEnabled = ValueNotifier(false);
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mfaEnabled.value = prefs.getBool('mfaEnabled') ?? false;
    privateAccountEnabled.value = prefs.getBool('privateAccountEnabled') ?? false;
    phoneController.text = prefs.getString('recoveryPhone') ?? '';
  }

  Future<void> savePreference(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  void updatePhone() {
    savePreference('recoveryPhone', phoneController.text);
    showSnackBar('Phone updated!');
  }

  // Function to reset the password
  void resetPassword(BuildContext context) {
    // showSnackBar(context, 'Password reset! New password: NewPassword123');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 34, 38, 42),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white70),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Security', style: TextStyle(fontSize: 4.sp(context), fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                // Password Section
                buildSectionTitle('Password'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('********'),
                    TactileButton(
                      onTap: () => resetPassword(context),
                      child: GradientContainer(
                        gradient1: red,
                        gradient2: purp,
                        height: .5.h(context),
                        width: .5.w(context),
                        neonGlow: purp,
                        text: 'Reset',
                        textSize: 12,
                        borderColor: Colors.transparent,
                        borderRadius: 500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // MFA Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MFA',
                      style: TextStyle(fontSize: 3.sp(context)),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: mfaEnabled,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: .75,
                          child: Switch(
                            value: value,
                            onChanged: (bool newValue) {
                              mfaEnabled.value = newValue;
                              // savePaypalPreference(newValue);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                // Recovery Phone Section

                buildRecoveryPhoneInput('Recovery Phone #', phoneController, updatePhone),
                const Divider(),
                const SizedBox(height: 10),
                buildSectionTitle('Privacy'),
                // Private Account Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Private Account',
                      style: TextStyle(fontSize: 3.sp(context)),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: privateAccountEnabled,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: .75,
                          child: Switch(
                            value: value,
                            onChanged: (bool newValue) {
                              privateAccountEnabled.value = newValue;
                              // savePaypalPreference(newValue);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white70));
  }

  Widget buildPasswordReset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('********'),
        TactileButton(
          onTap: () => showSnackBar('Password reset! New password: NewPassword123'),
          child: buildGradientButton('Reset'),
        ),
      ],
    );
  }

  Widget buildRecoveryPhoneInput(String label, TextEditingController controller, VoidCallback onUpdate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 3.sp(context), color: Colors.white70)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter $label', border: InputBorder.none),
              ),
            ),
            const SizedBox(width: 10),
            TactileButton(
              onTap: onUpdate,
              child: GradientContainer(
                gradient1: Colors.red,
                gradient2: purp,
                height: 5,
                width: 15,
                neonGlow: red,
                text: 'Update',
                textSize: 2.sp(context),
                borderColor: Colors.transparent,
                borderRadius: 500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGradientButton(String text) {
    return GradientContainer(
      gradient1: Colors.red,
      gradient2: purp,
      height: 5,
      width: 15,
      neonGlow: red,
      text: 'Update',
      textSize: 2.sp(context),
      borderColor: Colors.transparent,
      borderRadius: 500,
    );
  }

  @override
  void dispose() {
    mfaEnabled.dispose();
    privateAccountEnabled.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
