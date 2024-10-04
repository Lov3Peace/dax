import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bio_event.dart';
import 'bio_state.dart';

class BioBloc extends Bloc<BioEvent, BioState> {
  BioBloc() : super(BioInitial()) {
    on<LoadBio>(_onLoadBio);
    on<SaveBio>(_onSaveBio);
  }

  // Method to load the bio from shared preferences
  Future<void> _onLoadBio(LoadBio event, Emitter<BioState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final savedBio = prefs.getString('bio') ?? ''; // Load saved bio, empty if none
    emit(BioLoaded(savedBio));
  }

  // Method to save the bio into shared preferences
  Future<void> _onSaveBio(SaveBio event, Emitter<BioState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bio', event.bio); // Save bio to shared preferences
    emit(BioLoaded(event.bio)); // Emit the new state with the updated bio
  }
}
