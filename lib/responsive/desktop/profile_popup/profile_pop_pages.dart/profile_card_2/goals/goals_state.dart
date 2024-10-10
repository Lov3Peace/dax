// goal_state
abstract class GoalState {}

class GoalInitialState extends GoalState {}

class GoalListState extends GoalState {
  final List<Map<String, String>> goals; // Map to store goal and its timeframe

  GoalListState(this.goals);
}
