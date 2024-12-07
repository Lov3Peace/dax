import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

// Location States
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String address;

  LocationLoaded(this.address);
}

class LocationError extends LocationState {
  final String errorMessage;

  LocationError(this.errorMessage);
}

// Location Cubit
class LocationBloc extends Cubit<LocationState> {
  LocationBloc() : super(LocationInitial());

  // Request location and handle permission logic
  Future<void> getLocation() async {
    emit(LocationLoading());

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationError("Location services are disabled."));
      resetButton();
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationError("Location permissions are denied."));
        resetButton();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(LocationError("Location permissions are permanently denied. We cannot request permissions."));
      resetButton();
      return;
    }

    // Get the location if permissions are granted
    try {
      Position position = await Geolocator.getCurrentPosition();

      // Reverse geocoding: Convert latitude and longitude to an address
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        emit(LocationLoaded(address));
      } else {
        emit(LocationError("Failed to get address."));
        resetButton();
      }
    } catch (e) {
      emit(LocationError("Failed to get location."));
      resetButton();
    }
  }

  // Reset button by transitioning back to initial state
  void resetButton() {
    Future.delayed(Duration(seconds: 2), () {
      emit(LocationInitial()); // Reset the state after 2 seconds delay
    });
  }
}
