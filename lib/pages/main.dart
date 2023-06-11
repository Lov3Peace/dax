import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../responsive/desktop/desktop_dashboard.dart';
import '../responsive/mobile/mobile_dashboard.dart';
import '../responsive/tablet/tablet_dashboard.dart';
import 'dashboard.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'testing_widgets.dart';

void main() {
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
    return MaterialApp(
      //builder: (context, widget) => ResponsiveBreakpoints.builder(child: ClampingScrollWrapper.builder(context, widget!), breakpoints: []),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          colorScheme:
              const ColorScheme.dark(secondary: red, onSurface: Colors.white),
          scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)),
      home: ResponsiveLayout(
        mobileScaffold: const MobileDashboard(),
        tabletScaffold: const TabletDashboard(),
        desktopScaffold: const DesktopDashboard(),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const ProfilePage(),
    const Testing(),
    const Dashboard()
  ];
  @override
  Widget build(BuildContext context) {
    double deckHeight = MediaQuery.of(context).size.height * 0.21;
    return Scaffold(
      extendBody: true,
      body: pages[currentPage],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     debugPrint('Floating Action Button');
      //   },
      //   foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   hoverColor: Colors.amber[700],
      //   child: const Icon(Icons.add),
      // ),
      // bottomNavigationBar: NavigationBar(
      //     backgroundColor: tran,
      //     animationDuration: const Duration(seconds: 1),
      //     destinations: const [
      //       NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //       NavigationDestination(
      //           icon: Icon(Icons.account_circle), label: 'Profile'),
      //       NavigationDestination(icon: Icon(Icons.settings), label: 'Testing'),
      //       NavigationDestination(
      //           icon: Icon(Icons.dashboard), label: 'Dashboard'),
      //     ],
      //     onDestinationSelected: (int index) {
      //       currentPage = index;
      //       setState(() {
      //         currentPage = index;
      //       });
      //     },
      //     selectedIndex: currentPage),
    );
  }
}

class Stacks extends StatelessWidget {
  const Stacks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xA9444444),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Color(0x4E000000),
              offset: Offset(0, 8),
            )
          ]),
      constraints: const BoxConstraints(maxHeight: 700, maxWidth: 1500),
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Stack(
        alignment: const AlignmentDirectional(-0.8, 0.7),
        children: const [
          // Text('Projects',
          //     style: TextStyle(
          //         fontFamily: 'Gontserrat',
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500)),
        ],
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
