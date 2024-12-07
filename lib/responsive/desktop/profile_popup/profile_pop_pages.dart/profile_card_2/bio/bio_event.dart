abstract class BioEvent {}

// Event to load the bio from shared preferences
class LoadBio extends BioEvent {}

// Event to save the bio to shared preferences
class SaveBio extends BioEvent {
  final String bio;

  SaveBio(this.bio);
}
