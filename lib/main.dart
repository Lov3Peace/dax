import 'dart:async';
import 'package:flutter_application_1/util/auth/loginCheck.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:flutter_application_1/util/imports.dart';
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
        ChangeNotifierProvider(create: (context) => ButtonState()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        // Add more providers as needed
      ],
      child: const MyApp(),
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
  @override
  void initState() {
    super.initState();
  }

  // final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          colorScheme:
              const ColorScheme.dark(secondary: red, onSurface: Colors.white),
          scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17)),
    );
  }
}

// Used to fix Hero animation bug
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
