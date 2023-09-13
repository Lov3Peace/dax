import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:flutter_application_1/util/auth/auth_check.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC6cmRlApktLp8pr73JJ9ulx9TOxeYI4_o",
            appId: "1:28990487504:web:1c7d24fea847542a88d7d5",
            messagingSenderId: "28990487504",
            projectId: "omni-fb089"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

const Color red = Color.fromARGB(255, 255, 85, 85);
const Color purp = Color.fromARGB(255, 182, 47, 255);
const Color blue = Color.fromARGB(255, 59, 193, 255);
const Color orange = Colors.orange;
const Color orangeGlow = Colors.deepOrange;
const Color green = Color.fromARGB(255, 157, 255, 45);
const Color greenGlow = Color.fromARGB(169, 136, 255, 0);
const Color tran = Color.fromARGB(0, 0, 0, 0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        //builder: (context, widget) => ResponsiveBreakpoints.builder(child: ClampingScrollWrapper.builder(context, widget!), breakpoints: []),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            colorScheme:
                const ColorScheme.dark(secondary: red, onSurface: Colors.white),
            scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17)),
        // ignore: prefer_const_constructors
        home: ResponsiveLayout(
          mobileVersion: AuthCheck(),
          tabletVersion: AuthCheck(),
          desktopVersion: AuthCheck(),
        ),
      ),
    );
  }
}

Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
