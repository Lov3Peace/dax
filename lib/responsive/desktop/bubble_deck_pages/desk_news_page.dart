import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../util/button_state.dart';
import '../../../util/soft_close.dart';
import '../../../util/test_list.dart';
import '../dashboard/title_bubble.dart';
import '../desk_decks.dart';
import '../util/web_ui_template.dart';

class DeskNewsPage extends StatefulWidget {
  const DeskNewsPage({Key? key}) : super(key: key);

  @override
  State<DeskNewsPage> createState() => _DeskNewsPageState();
}

class _DeskNewsPageState extends State<DeskNewsPage> with AnimationMixin {
  //globals
  late Animation<double> scale;
  late Animation<double> opacity;
  late AnimationController widthController;
  late AnimationController heightController;
  late AnimationController colorController;

  //final dashboardDecksList = dashboardDecks(0, 1, 2, 4);

  @override
  void initState() {
    // TODO: implement initState
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
          title: "News",
          button1: ProjectsButton(),
          button2: CommunitiesButton(),
          button3: SocialsButton(),
          //Column for Title, Dock Buttons, and Content
          child: Expanded(
            child: StaggerLoad(
              widgets: test_big_list,
              padding: EdgeInsets.all(0.5.w(context)),
              physics: const BouncingScrollPhysics(),
              duration: 300,
              scrollDirection: Axis.vertical,
              delay: 5,
              scale: 1.02,
              layer: 1,
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

// class DeskNewsCont extends StatefulWidget {
//   const DeskNewsCont({super.key});

//   @override
//   State<DeskNewsCont> createState() => _DeskNewsContState();
// }

// class _DeskNewsContState extends State<DeskNewsCont> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80.h(context),
//       width: 71.w(context),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(1.5.w(context)),
//         color: const Color.fromARGB(185, 21, 19, 22),
//         border: Border.all(color: deckBorderColor),
//       ),
//       child: ListView.builder(
//         itemExtent: 420,
//         physics: const BouncingScrollPhysics(),
//         itemCount: 3,
//         itemBuilder: (BuildContext context, int index) {
//           return AnimationConfiguration.staggeredList(
//             delay: const Duration(milliseconds: 500),
//             position: index,
//             duration: const Duration(milliseconds: 700),
//             child: SlideAnimation(
//               horizontalOffset: 100,
//               curve: Curves.easeOutBack,
//               child: FadeInAnimation(
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                             return const KeyboardsDeck();
//                           }));
//                         },
//                         child: NewsDeck()),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class NewsBubbleDock extends StatelessWidget {
  const NewsBubbleDock({super.key});

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
