import 'dart:async';
import 'package:flutter_application_1/util/auth/loginCheck.dart';
import 'package:flutter_application_1/util/auth/onboarding_page.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/util/button_state.dart';
import 'package:flutter_application_1/responsive/desktop/util/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'responsive/desktop/firebase_tools/username_change.dart';
import 'responsive/desktop/util/error_page.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ButtonState()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Add more providers as needed
      ],
      child: MyApp(),
    ),
  );
}

const Color red = Color.fromARGB(255, 255, 85, 85);
const Color purp = Color.fromARGB(255, 182, 47, 255);
const Color pink = Color.fromARGB(255, 255, 148, 253);
const Color blue = Color.fromARGB(255, 59, 193, 255);
const Color orange = Colors.orange;
const Color orangeGlow = Colors.deepOrange;
const Color green = Color.fromARGB(255, 90, 255, 45);
const Color greenGlow = Color.fromARGB(169, 34, 255, 0);
const Color hoverGreen = Color.fromARGB(255, 170, 255, 147);
const Color tran = Color.fromARGB(0, 0, 0, 0);
const Color white = Colors.white;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;
  @override
  void initState() {
    super.initState();
    checkRes();
    if (checkRes != 200) {
      setState(() {
        loggedIn = false;
      });
      navigatorKey?.currentState?.pushReplacementNamed('/launch');
      print("User has been automatically logged out.");
    } else {
      loggedIn = true;
    }
    print("User logged in: ${loggedIn}");
    Timer.periodic(Duration(seconds: 30), (timer) {
      loginCheck(); // call the function, don't await or call it prematurely
    });
  }

  checkRes() async {
    var resStatus = await loginCheck();
    return resStatus;
  }

  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // if (!loggedIn) {
    //   navigatorKey?.currentState?.pushReplacementNamed('/launch');
    //   print("User has been automatically logged out.");
    // }
    timeDilation = 1;
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: loggedIn ? '/' : '/launch',
      onGenerateRoute: (settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            loggedIn ? routes[settings.name]! : routes['/launch']!,
        fullscreenDialog: true,
      ),
      onUnknownRoute: (settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => ErrorPage(),
        fullscreenDialog: true,
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          colorScheme:
              const ColorScheme.dark(secondary: red, onSurface: Colors.white),
          scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17)),
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
