import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Initialize with dummy data
    add(UpdateTitles(['Developer', 'Designer', 'Manager']));
    add(UpdateCrests(['assets/creator.png', 'assets/master.png', 'assets/diamond.png']));
    add(UpdateProjects(['Project A', 'Project B', 'Project C']));
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateTitles) {
      yield TitlesUpdated(event.titles);
    } else if (event is UpdateCrests) {
      yield CrestsUpdated(event.crests);
    } else if (event is UpdateProjects) {
      yield ProjectsUpdated(event.projects);
    }
  }
}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class TitlesUpdated extends ProfileState {
  final List<String> titles;
  TitlesUpdated(this.titles);
}

class CrestsUpdated extends ProfileState {
  final List<String> crests;
  CrestsUpdated(this.crests);
}

class ProjectsUpdated extends ProfileState {
  final List<String> projects;
  ProjectsUpdated(this.projects);
}

abstract class ProfileEvent {}

class UpdateTitles extends ProfileEvent {
  final List<String> titles;
  UpdateTitles(this.titles);
}

class UpdateCrests extends ProfileEvent {
  final List<String> crests;
  UpdateCrests(this.crests);
}

class UpdateProjects extends ProfileEvent {
  final List<String> projects;
  UpdateProjects(this.projects);
}
