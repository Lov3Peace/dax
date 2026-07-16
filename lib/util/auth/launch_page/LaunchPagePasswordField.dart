import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/routes/go_routes.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';
import 'package:flutter_application_1/util/ErrorMessage.dart';
import 'package:flutter_application_1/util/auth/LoginRes.dart';
import 'package:flutter_application_1/util/auth/launch_page/RiveLoadingAnimation.dart';
import 'package:flutter_application_1/util/auth/registerForm.dart';
import 'package:flutter_application_1/util/providers/userAuthProvider.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rive/rive.dart';

class LaunchPagePasswordField extends StatelessWidget {
  LaunchPagePasswordField(
      {super.key,
      required this.passwordFocusNode,
      required this.passwordController,
      required this.usernameController,
      required this.rememberMe});

  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final bool rememberMe;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: passwordFocusNode,
      cursorColor: red,
      style: TextStyle(fontSize: 3.sp(context)),
      controller: passwordController,
      // handles pressing 'Enter'
      onSubmitted: (value) async {
        // TO-DO: MOVE THIS TO A DEDICATED WIDGET
        final userAuthProvider = context.read<UserAuthProvider>();
        final userProvider = context.read<UserProvider>();
        final LoginRes res = await userAuthProvider.login(
          usernameController.text,
          passwordController.text,
          rememberMe,
        );
        if (!context.mounted) return;
        if (!res.success) {
          showDialog(
              context: context,
              builder: (context) {
                return ErrorMessage(message: res.error);
              });
          passwordFocusNode.requestFocus();
        } else {
          userProvider.saveUsername(res.body["username"]);
          userProvider.saveUserData(res.body);
          // Navigate to Dashboard
          showDialog(
              context: context,
              builder: (context) {
                return const RiveLoadingAnimation();
              });
          Future.delayed(Duration(seconds: 3), () {
            router.pop();
            router.go("/");
          });
        }

        passwordController.clear();
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: grey,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 1.w(context)),
          child: TactileButton(
              onTap: () async {
                // TO-DO: MOVE THIS TO A DEDICATED WIDGET
                final userAuthProvider = context.read<UserAuthProvider>();
                final userProvider = context.read<UserProvider>();
                final LoginRes res = await userAuthProvider.login(
                  usernameController.text,
                  passwordController.text,
                  rememberMe,
                );
                if (!context.mounted) return;
                if (!res.success) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorMessage(message: res.error);
                      });
                  passwordFocusNode.requestFocus();
                } else {
                  userProvider.saveUsername(res.body["username"]);
                  userProvider.saveUserData(res.body);
                  // Navigate to Dashboard
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const RiveLoadingAnimation();
                      });
                  Future.delayed(Duration(seconds: 3), () {
                    router.pop();
                    router.go("/");
                  });
                }
              },
              scale: 1.1,
              child: Icon(
                Icons.arrow_circle_right_rounded,
              )),
        ),
        contentPadding: EdgeInsets.all(1.25.w(context)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w(context)),
          borderSide: BorderSide(
            color: const Color.fromARGB(151, 255, 255, 255),
            width: 0.05.w(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.w(context)),
          borderSide:
              const BorderSide(color: Color.fromARGB(151, 255, 255, 255)),
        ),
      ),
    );
  }
}
