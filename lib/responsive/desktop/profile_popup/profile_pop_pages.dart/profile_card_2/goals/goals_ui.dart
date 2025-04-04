import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'goals_bloc.dart';
import 'goals_event.dart';
import 'goals_state.dart';

class GoalsUi extends StatelessWidget {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _timeFrameController = TextEditingController();

  GoalsUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoalBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                hintText: 'Enter your goal here',
                border: InputBorder.none, // This removes the underline
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  // Add the goal to the Bloc
                  BlocProvider.of<GoalBloc>(context).add(AddGoalEvent(value));
                  _goalController.clear(); // Clear the input after submission
                }
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<GoalBloc, GoalState>(
              builder: (context, state) {
                if (state is GoalListState && state.goals.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.goals.length,
                      itemBuilder: (context, index) {
                        final goal = state.goals[index]["goal"];
                        final timeFrame = state.goals[index]["timeFrame"];
                        return ListTile(
                          title: Text(goal ?? ''),
                          subtitle: timeFrame?.isNotEmpty == true
                              ? Text('Time frame: $timeFrame')
                              : TextField(
                                  controller: _timeFrameController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter time frame',
                                  ),
                                  onSubmitted: (timeValue) {
                                    if (timeValue.isNotEmpty) {
                                      BlocProvider.of<GoalBloc>(context).add(
                                        AddTimeFrameEvent(goal!, timeValue),
                                      );
                                      _timeFrameController.clear();
                                    }
                                  },
                                ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text("No goals added yet.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
