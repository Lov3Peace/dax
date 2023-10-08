import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../main.dart';
import '../../../mobile/mobile_constants.dart';
import '../../../mobile/mobile_dashboard.dart';
import 'tab_signin_form.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SendCodeButton(
              onTap: sendcodebtn,
            ),
          ],
        ),
      ),
    );
  }

  void sendcodebtn() {}
}

class SendCodeButton extends StatefulWidget {
  final Function()? onTap;

  SendCodeButton({super.key, required this.onTap});

  @override
  State<SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<SendCodeButton> {
  //controlls button
  Control control = Control.stop;

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: control,
      startPosition: 0,
      tween: Tween(begin: 1.0, end: 0.8),
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      onCompleted: () {
        reverseShrink();
      },
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: pressed,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [purp, red]),
              boxShadow: const [
                BoxShadow(
                    color: red, blurRadius: 20, blurStyle: BlurStyle.solid)
              ],
              borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
          child: const Center(
            child: Text(
              'Send Code',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  void pressed() {
    // toggle between control instructions

    setState(() {
      control = Control.play;

      // showGeneralDialog(
      //   barrierDismissible: true,
      //   barrierLabel: "Sign in",
      //   context: context,
      //   pageBuilder: (context, _, __) => Center(
      //     child: Container(
      //       height: 620,
      //       margin: EdgeInsets.symmetric(horizontal: 16),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(40),
      //         ),
      //       ),
      //     ),
      //   ),
      // );
      // Future.delayed(const Duration(milliseconds: 200)).then((_) {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
      //     return const MobileDashboard();
      //   }));
      // });
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}
