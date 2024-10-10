// goal_event
abstract class GoalEvent {}

class AddGoalEvent extends GoalEvent {
  final String goal;

  AddGoalEvent(this.goal);
}

class AddTimeFrameEvent extends GoalEvent {
  final String goal;
  final String timeFrame;

  AddTimeFrameEvent(this.goal, this.timeFrame);
}
