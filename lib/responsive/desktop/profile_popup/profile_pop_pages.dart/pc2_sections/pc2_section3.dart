import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import '../../../../../main.dart';
import '../../../../../util/gradient_label.dart';
import '../../../desk_decks.dart';

/// Profile Card 2 Section 3: Stateful projects and goals section
///
/// Provides UI for adding and managing user goals, including a dialog
/// interface for viewing and removing items. Goals are stored in local
/// state and updated dynamically. Includes a placeholder for future
/// project-related content and expansion.

class Pc2Section3 extends StatefulWidget {
  Pc2Section3({super.key});

  @override
  State<Pc2Section3> createState() => _Pc2Section3State();
}

class _Pc2Section3State extends State<Pc2Section3> {
  final TextEditingController goalsController = TextEditingController();

  List<String> goals = [];

  void addGoal() {
    if (goalsController.text.isNotEmpty) {
      setState(() {
        goals.add(goalsController.text);
        goalsController.clear();
      });
    }
  }

  void removeGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
    showGoalsDialog();
  }

  void showGoalsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Your Goals'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (goals.isNotEmpty) ...[
                    const Text('Goals:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ...goals.asMap().entries.map((entry) => ListTile(
                          leading: Text("${entry.key + 1}"),
                          title: Text(entry.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              setState(() => goals.removeAt(entry.key));
                              this.setState(() {});
                            },
                          ),
                        )),
                  ],
                ],
              ),
              actions: [
                TactileButton(
                  onTap: () {
                    setState(() {
                      // shortTermGoals.clear();
                      goals.clear();
                    });
                    this.setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: GradientContainer(
                    gradient1: red,
                    gradient2: purp,
                    height: 4.h(context),
                    width: 7.w(context),
                    neonGlow: purp,
                    text: 'Delete Goals',
                    textSize: 2.5.sp(context),
                    borderColor: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: 500,
                  ),
                ),
                TactileButton(
                  onTap: () => Navigator.of(context).pop(),
                  child: GradientContainer(
                    gradient1: red,
                    gradient2: purp,
                    height: 4.h(context),
                    width: 7.w(context),
                    neonGlow: purp,
                    text: 'Close',
                    textSize: 2.5.sp(context),
                    borderColor: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: 500,
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildProjects(),
            SizedBox(
              height: 1.h(context),
            ),
            buildGoals(),
          ],
        ),
      ),
    );
  }

  buildProjects() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(1.5.h(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: TextStyle(
                    fontSize: 5.sp(context), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildGoals() {
    return Container(
      height: 21.5.h(context),
      width: 20.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(1.5.h(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals',
                style: TextStyle(
                    fontSize: 5.sp(context), fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: goalsController,
                decoration: const InputDecoration(
                  hintText: ' Any Goals?',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none, // No underline
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    addGoal();
                    goalsController.clear();
                  }
                },
              ),
              SizedBox(
                height: 1.h(context),
              ),
              goals.isEmpty
                  ? const Center(
                      child: Text(
                        'You have no current goals.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : TactileButton(
                      onTap: showGoalsDialog,
                      child: GradientContainer(
                        gradient1: red,
                        gradient2: purp,
                        height: 4.h(context),
                        width: 7.w(context),
                        neonGlow: purp,
                        text: 'View Goals',
                        textSize: 2.5.sp(context),
                        borderColor: Colors.transparent,
                        borderRadius: 500,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
