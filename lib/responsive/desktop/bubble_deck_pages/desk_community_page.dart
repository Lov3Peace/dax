import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/button_state.dart';
import '../../../util/soft_close.dart';
import '../../../util/test_list.dart';
import '../util/title_bubble.dart';
import '../desk_decks.dart';
import '../large_stagger_load.dart';
import '../util/web_ui_template.dart';

class DeskCommunitiesPage extends StatefulWidget {
  const DeskCommunitiesPage({Key? key}) : super(key: key);

  @override
  State<DeskCommunitiesPage> createState() => _DeskCommunitiesPageState();
}

class _DeskCommunitiesPageState extends State<DeskCommunitiesPage>
    with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  @override
  void initState() {
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    controller.stop();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ButtonState>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: WebUiTemplate(
          title: "Communities",
          button1: ProjectsButton(),
          button2: SocialsButton(),
          button3: NewsButton(),
          //Column for Title, Dock Buttons, and Content
          child: Expanded(
            child: LargeStaggerLoad(
              widgets: test_big_list,
              scale: 1.02,
              constraints: BoxConstraints(minHeight: 350),
              childHeight: 50.h(context),
              childWidth: 35.w(context),
              childPadding: EdgeInsets.all(0.5.w(context)),
              physics: const NeverScrollableScrollPhysics(),
            ),
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

class CommunitiesBubbleDock extends StatelessWidget {
  const CommunitiesBubbleDock({super.key});

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
          const SocialsButton()
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
          const ProjectsButton()
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
