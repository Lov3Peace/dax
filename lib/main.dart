import 'dart:async';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/FeedSocketIoProvider.dart';
import 'package:flutter_application_1/util/providers/appStateProvider.dart';
import 'package:flutter_application_1/util/providers/locationServicesProvider.dart';
import 'package:flutter_application_1/util/providers/projectProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/util/socket_io/socket_io_client.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'util/providers/userAuthProvider.dart';
import 'util/providers/userProvider.dart';
import 'responsive/desktop/routes/go_routes.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_application_1/util/logger/CarbonLogger.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // recommended to initalize Rive before running the app
  await rive.RiveNative.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => LocationServicesProvider()),
        ChangeNotifierProvider(create: (_) => FeedSocketIoProvider()),
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
    final feedSocketIoProvider = context.read<FeedSocketIoProvider>();
    SocketIoClient.socket.connect();
    SocketIoClient.socket.on("connected", (res) => logger.w(res));
    SocketIoClient.socket.onReconnect((_) {
      feedSocketIoProvider.joinProjectRoom(1);
    });
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
// Color deckBorderColor = const Color.fromARGB(182, 75, 75, 75);
Color grey = Colors.grey.shade500;
Color darkGrey = Colors.grey.shade700;

//FONTSIZES
double headerlowerlimit = 26;
double subheaderlowerlimit = 18;
double paragraphlowerlimit = 16;
double smallestLowerLimit = 12;

//PADDING
double desktopContainerPadLowerLimit = 20;
double mobilContainerPadLowerLimit = 10;

// BORDER RADIUS
double cardBorderRadiusLowerLimit = 20;

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
