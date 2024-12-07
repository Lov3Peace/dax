abstract class BioState {}

// Initial state when bio has not been loaded yet
class BioInitial extends BioState {}

// State when the bio is successfully loaded
class BioLoaded extends BioState {
  final String bio;

  BioLoaded(this.bio);
}
