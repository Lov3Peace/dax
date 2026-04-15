import 'dart:async';
import 'package:flutter_application_1/responsive/desktop/util/test_page.dart';
import 'package:flutter_application_1/util/auth/loginCheck.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/appStateProvider.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
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
import 'responsive/desktop/util/error_page.dart';
import 'util/providers/userAuthProvider.dart';
import 'util/providers/userProvider.dart';
import 'responsive/desktop/util/go_routes.dart';

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
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (context) => ButtonState()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        // Add more providers as needed
      ],
      child: const MyApp(),
    ),
  );
}

// Hostname determined by environment
const hostname =
    String.fromEnvironment("HOSTNAME", defaultValue: "http://localhost:7777");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.redHatDisplay().fontFamily,
          colorScheme:
              const ColorScheme.dark(secondary: red, onSurface: Colors.white),
          scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17)),
    );
  }
}

//COLORS
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
const Color deckBackgroundColor = Color.fromARGB(160, 22, 19, 22);

//FONTSIZES
double headerlowerlimit = 20;
double subheaderlowerlimit = 18;
double paragraphlowerlimit = 16;
double smallestLowerLimit = 12;

//PADDING
double desktopContainerPadLowerLimit = 20;
double mobilContainerPadLowerLimit = 10;

// Used to fix Hero animation bug
Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  // Determine which child to show based on push or pop
  final Widget shuttleChild = (flightDirection == HeroFlightDirection.push)
      ? (toHeroContext.widget as Hero).child
      : (fromHeroContext.widget as Hero).child;

  return Material(
    type: MaterialType.transparency, // no background, respects child size
    textStyle: DefaultTextStyle.of(fromHeroContext).style,
    child: shuttleChild,
  );
}

Widget flightShuttleBuilder2(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection direction,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final Widget toHero = toHeroContext.widget;
  final Widget fromHero = fromHeroContext.widget;

  // Wrap in an AnimatedBuilder to fade the contents
  return AnimatedBuilder(
    animation: animation,
    builder: (context, _) {
      final fadeValue = direction == HeroFlightDirection.pop
          ? 1.0 - animation.value.clamp(0.0, 1.0)
          : animation.value.clamp(0.0, 1.0);

      // Only fade the text, not the whole hero shape
      return Opacity(
        opacity: fadeValue,
        child: direction == HeroFlightDirection.push ? toHero : fromHero,
      );
    },
  );
}

Widget textFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return Material(
    type: MaterialType.transparency, // no background, respects child size
    textStyle: DefaultTextStyle.of(fromHeroContext).style,
    child: toHeroContext.widget,
  );
}

Widget textFlightShuttleBuilder2(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  // Determine which child to show based on push or pop
  final Widget shuttleChild = (flightDirection == HeroFlightDirection.push)
      ? (toHeroContext.widget as Hero).child
      : (fromHeroContext.widget as Hero).child;

  return Material(
    type: MaterialType.transparency, // no background, respects child size
    // textStyle: TextStyle(color: tran),
    child: shuttleChild,
  );
}

Widget staticFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return Material(
    type: MaterialType.transparency, // no background, respects child size
    textStyle: DefaultTextStyle.of(fromHeroContext).style,
    child: toHeroContext.widget,
  );
}
