import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../main.dart';
import '../../responsive/mobile/mob_constants.dart';
import '../gradient_label.dart';
import '../tactile_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset link sent!'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth / 4,
                    ),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TactileButton(
                  onTap: passwordReset,
                  child: GradientContainer(
                    gradient1: purp,
                    gradient2: red,
                    height: 10,
                    width: 30,
                    neonGlow: red,
                    text: 'Reset Password',
                    textSize: 14,
                    borderColor: Colors.white,
                    borderRadius: 500,
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

// class SendCodeButton extends StatefulWidget {
//   SendCodeButton({
//     super.key,
//   });

//   @override
//   State<SendCodeButton> createState() => _SendCodeButtonState();
// }

// class _SendCodeButtonState extends State<SendCodeButton> {
//   //controlls button
//   Control control = Control.stop;

//   @override
//   Widget build(BuildContext context) {
//     return CustomAnimationBuilder<double>(
//       control: control,
//       startPosition: 0,
//       tween: Tween(begin: 1.0, end: 0.8),
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.linear,
//       onCompleted: () {
//         reverseShrink();
//       },
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: value,
//           child: child,
//         );
//       },
//       child: GestureDetector(
//         onTap: passwordReset,
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           margin: const EdgeInsets.symmetric(horizontal: 35),
//           decoration: BoxDecoration(
//               gradient: const LinearGradient(colors: [purp, red]),
//               boxShadow: const [
//                 BoxShadow(
//                     color: red, blurRadius: 10, blurStyle: BlurStyle.solid)
//               ],
//               borderRadius: BorderRadius.all(Radius.circular(screenWidth / 4))),
//           child: const Center(
//             child: Text(
//               'Reset Password',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// // Reset the password for user
//   void passwordReset() {
//     // toggle between control instructions

//     setState(() {
//       control = Control.play;
//     });
//   }

//   void reverseShrink() {
//     setState(() {
//       control = Control.playReverse;
//     });
//   }
// }
