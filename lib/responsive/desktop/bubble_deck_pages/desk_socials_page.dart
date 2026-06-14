import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/util/stagger_load.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/util/providers/locationServicesProvider.dart';
import 'package:flutter_application_1/util/weather_date.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/animations/soft_close.dart';
import '../../../util/test_list.dart';
import '../desk_decks.dart';
import '../util/web_ui_template.dart';

class DeskSocialsPage extends StatefulWidget {
  const DeskSocialsPage({Key? key}) : super(key: key);

  @override
  State<DeskSocialsPage> createState() => _DeskSocialsPageState();
}

LocationServicesProvider locationServicesProvider = locationServicesProvider;

class _DeskSocialsPageState extends State<DeskSocialsPage> with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  //final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

  @override
  void initState() {
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    locationServicesProvider = context.read<LocationServicesProvider>();
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: WebUiTemplate(
        title: "Socials",
        button1: ProjectsButton(),
        button2: CommunitiesButton(),
        button3: NewsButton(),
        //Column for Title, Dock Buttons, and Content
        child: Container(
          height: 80.h(context),
          width: 71.w(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  // Title of Screen
                  WeatherDate(
                    height: 5.w(context),
                    width: 17.25.w(context),
                    constraints: BoxConstraints(minWidth: 250, minHeight: 50),
                    // height: 50,
                  ),

                  //
                  //Houses Deck Buttons
                  Container(
                    color: tran,
                    child: const Column(
                      children: [SocialsBubbleDock()],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h(context),
              ),
              Expanded(
                child: StaggerLoad(
                  widgets: test_big_list,
                  childPadding: EdgeInsets.all(0.5.w(context)),
                  physics: const BouncingScrollPhysics(),
                  duration: 300,
                  scrollDirection: Axis.vertical,
                  delay: 5,
                  scale: 1.02,
                  layer: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}

class SocialsBubbleDock extends StatelessWidget {
  const SocialsBubbleDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h(context),
      width: 30.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5.w(context)),
        color: const Color.fromARGB(185, 21, 19, 22),
        border: Border.all(color: deckBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ProjectsButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          const CommunitiesButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
          const NewsButton()
              .animate()
              .slideX(
                  begin: 0.25,
                  end: 0,
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 400),
                  curve: const SoftClose())
              .fadeIn(begin: 0, duration: const Duration(milliseconds: 500)),
        ],
      ),
    );
  }
}
