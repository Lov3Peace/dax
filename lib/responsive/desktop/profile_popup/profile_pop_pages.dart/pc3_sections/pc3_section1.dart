import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

class Pc3Section1 extends StatefulWidget {
  Pc3Section1({super.key});

  @override
  State<Pc3Section1> createState() => _Pc3Section1State();
}

class _Pc3Section1State extends State<Pc3Section1> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  String location = "Location not available";

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = prefs.getString('username') ?? '';
      emailController.text = prefs.getString('email') ?? '';
    });
  }

  Future<void> savePreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void updateUsername() {
    savePreference('username', usernameController.text);
    showSnackBar('Username updated!');
  }

  void updateEmail() {
    savePreference('email', emailController.text);
    showSnackBar('Email updated!');
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar("Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar("Location permissions are permanently denied.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      location = "Lat: ${position.latitude}, Lng: ${position.longitude}";
    });
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
                Text(
                  'General',
                  style: TextStyle(fontSize: 4.sp(context), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                buildInputField('Username', usernameController, updateUsername),
                const Divider(),
                buildInputField('Email', emailController, updateEmail),
                const Divider(),
                buildSectionLable('Location'),
                Text(location, style: const TextStyle(fontSize: 14, color: Colors.white)),
                const Divider(),
                buildSectionLable('Member Since'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionLable(String title) {
    return Text(title, style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white70));
  }

  Widget buildInputField(String label, TextEditingController controller, VoidCallback onUpdate) {
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
                text: 'Change',
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

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
