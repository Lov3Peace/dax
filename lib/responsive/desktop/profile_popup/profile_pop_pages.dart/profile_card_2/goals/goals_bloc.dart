// goal_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'goals_event.dart';
import 'goals_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  List<Map<String, String>> goals = [];

  GoalBloc() : super(GoalListState([])) {
    on<AddGoalEvent>((event, emit) {
      // Add the goal without a timeframe initially
      goals.add({"goal": event.goal, "timeFrame": ""});
      emit(GoalListState(List.from(goals))); // Emit new state with the updated list
    });

    on<AddTimeFrameEvent>((event, emit) {
      // Find the goal and add the timeframe
      final goalIndex = goals.indexWhere((g) => g["goal"] == event.goal);
      if (goalIndex != -1) {
        goals[goalIndex]["timeFrame"] = event.timeFrame;
      }
      emit(GoalListState(List.from(goals))); // Emit new state with the updated list
    });
  }
}
