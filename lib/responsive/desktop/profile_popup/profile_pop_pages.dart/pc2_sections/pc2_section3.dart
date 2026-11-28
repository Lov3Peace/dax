import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/userProvider.dart';
import 'package:flutter_application_1/util/ui/tactile_button.dart';
import 'package:provider/provider.dart';

import '../../../../../main.dart';
import '../../../../../util/providers/profileSocketIoProvider.dart';
import '../../../../../util/ui/gradient_label.dart';
import '../../../desk_decks.dart';

/// Profile Card 2 Section 3: Stateful projects and goals section
///
/// Provides UI for adding and managing user goals, including a dialog
/// interface for viewing and removing items. Goals are stored in local
/// state and updated dynamically. Includes a placeholder for future
/// project-related content and expansion.

class Pc2Section3 extends StatefulWidget {
  const Pc2Section3({super.key});

  @override
  State<Pc2Section3> createState() => _Pc2Section3State();
}

class _Pc2Section3State extends State<Pc2Section3> {
  final TextEditingController goalsController = TextEditingController();

  List<String> get goals => List<String>.from(
        context.read<ProfileProvider>().profile?['profile']?['goals'] ?? [],
      );

  bool get isOwner {
    final profile = context.read<ProfileProvider>().profile;
    final username = context.read<UserProvider>().username;

    return username.isNotEmpty && username == profile?['username'];
  }

  void addGoal() {
    if (!isOwner) return;

    final goal = goalsController.text.trim();
    final currentGoals = goals;

    if (goal.isEmpty || goal.length > 150 || currentGoals.length >= 5) {
      return;
    }

    context.read<ProfileProvider>().updateUserGoals([
      ...currentGoals,
      goal,
    ]);

    goalsController.clear();
  }

  void removeGoal(int index) {
    if (!isOwner) return;

    final updatedGoals = goals;
    updatedGoals.removeAt(index);

    context.read<ProfileProvider>().updateUserGoals(updatedGoals);
  }

  void showGoalsDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            final currentGoals = List<String>.from(
              provider.profile?['profile']?['goals'] ?? [],
            );

            final owner = isOwner;

            return AlertDialog(
              title: const Text('Your Goals'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (currentGoals.isNotEmpty) ...[
                      const Text(
                        'Goals:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...currentGoals.asMap().entries.map(
                            (entry) => ListTile(
                              leading: Text("${entry.key + 1}"),
                              title: Text(entry.value),
                              trailing: owner
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () => removeGoal(entry.key),
                                    )
                                  : null,
                            ),
                          ),
                    ],
                  ],
                ),
              ),
              actions: [
                if (owner && currentGoals.isNotEmpty)
                  TactileButton(
                    onTap: () {
                      context.read<ProfileProvider>().updateUserGoals([]);
                      Navigator.of(dialogContext).pop();
                    },
                    child: GradientContainer(
                      gradient1: red,
                      gradient2: purp,
                      height: 4.h(context),
                      width: 7.w(context),
                      neonGlow: purp,
                      text: 'Delete Goals',
                      textSize: 2.5.sp(context),
                      borderColor: Colors.transparent,
                      borderRadius: 500,
                    ),
                  ),
                TactileButton(
                  onTap: () => Navigator.of(dialogContext).pop(),
                  child: GradientContainer(
                    gradient1: red,
                    gradient2: purp,
                    height: 4.h(context),
                    width: 7.w(context),
                    neonGlow: purp,
                    text: 'Close',
                    textSize: 2.5.sp(context),
                    borderColor: Colors.transparent,
                    borderRadius: 500,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    goalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProfileProvider>();

    return CarouselContentsTemp(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildProjects(),
            SizedBox(height: 1.h(context)),
            buildGoals(),
          ],
        ),
      ),
    );
  }

  Widget buildProjects() {
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
                  fontSize: 5.sp(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGoals() {
    final currentGoals = goals;
    final owner = isOwner;

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
                  fontSize: 5.sp(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (owner && currentGoals.length < 5)
                TextField(
                  controller: goalsController,
                  maxLength: 150,
                  decoration: const InputDecoration(
                    hintText: 'Any Goals?',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (_) => addGoal(),
                ),
              SizedBox(height: 1.h(context)),
              currentGoals.isEmpty
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
