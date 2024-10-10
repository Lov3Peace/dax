import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsBloc extends Cubit<List<String>> {
  SkillsBloc() : super([]);

  void addSkill(String skill) {
    state.add(skill);
    emit(List.from(state)); // Emit a new state to notify listeners
  }

  void removeSkill(int index) {
    state.removeAt(index);
    emit(List.from(state)); // Emit a new state to notify listeners
  }
}
