import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import '../../../../../main.dart';
import '../../../../../util/gradient_label.dart';

class Pc2Section3 extends StatefulWidget {
  Pc2Section3({super.key});

  @override
  State<Pc2Section3> createState() => _Pc2Section3State();
}

class _Pc2Section3State extends State<Pc2Section3> {
  final TextEditingController shortTermController = TextEditingController();
  final TextEditingController longTermController = TextEditingController();
  List<String> shortTermGoals = [];
  List<String> longTermGoals = [];

  void addShortTermGoal() {
    if (shortTermController.text.isNotEmpty) {
      setState(() {
        shortTermGoals.add(shortTermController.text);
        shortTermController.clear();
      });
    }
  }

  void addLongTermGoal() {
    if (longTermController.text.isNotEmpty) {
      setState(() {
        longTermGoals.add(longTermController.text);
        longTermController.clear();
      });
    }
  }

  void removeShortTermGoal(int index) {
    setState(() {
      shortTermGoals.removeAt(index);
    });
    showGoalsDialog();
  }

  void removeLongTermGoal(int index) {
    setState(() {
      longTermGoals.removeAt(index);
    });
    showGoalsDialog();
  }
// This is a pop up so that you can see what goals you have and if you have completed them or not.
// if not than it stays on your list until it is completed or you delete it

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
                  if (shortTermGoals.isNotEmpty) ...[
                    const Text('Short-Term Goals:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...shortTermGoals.asMap().entries.map((entry) => ListTile(
                          leading: Text("${entry.key + 1}"),
                          title: Text(entry.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              setState(() => shortTermGoals.removeAt(entry.key));
                              this.setState(() {});
                            },
                          ),
                        )),
                  ],
                  if (longTermGoals.isNotEmpty) ...[
                    const Text('Long-Term Goals:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...longTermGoals.asMap().entries.map((entry) => ListTile(
                          leading: Text("${entry.key + 1}"),
                          title: Text(entry.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              setState(() => longTermGoals.removeAt(entry.key));
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
                      shortTermGoals.clear();
                      longTermGoals.clear();
                    });
                    this.setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: GradientContainer(
                    gradient1: red,
                    gradient2: purp,
                    height: 5,
                    width: 20,
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
                    height: 5,
                    width: 20,
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
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
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
                style: TextStyle(fontSize: 5.sp(context), fontWeight: FontWeight.bold),
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
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
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
                style: TextStyle(fontSize: 5.sp(context), fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: shortTermController,
                decoration: const InputDecoration(
                  hintText: 'Short-Term Goals?',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none, // No underline
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    addShortTermGoal();
                    shortTermController.clear();
                  }
                },
              ),
              TextField(
                controller: longTermController,
                decoration: const InputDecoration(
                  hintText: 'Long-Term Goals?',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none, // No underline
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    addLongTermGoal();
                    longTermController.clear();
                  }
                },
              ),
              Divider(),
              shortTermGoals.isEmpty && longTermGoals.isEmpty
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
                        height: 5,
                        width: 20,
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
