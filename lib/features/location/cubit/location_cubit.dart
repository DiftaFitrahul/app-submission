import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GPSPermisson {
  initial,
  success,
  denied,
  permanentlyDenied,
  end,
}

class LocationCubit extends Cubit<GPSPermisson> {
  LocationCubit() : super(GPSPermisson.initial);

  void requestGPS() async {
    final status = await Location().requestPermission();
    if (status == PermissionStatus.deniedForever) {
      emit(GPSPermisson.permanentlyDenied);
    } else if (status == PermissionStatus.denied) {
      emit(GPSPermisson.denied);
    } else {
      emit(GPSPermisson.success);
    }
  }

  void endGPSPermission() {
    emit(GPSPermisson.end);
  }

  Future<LatLng> getUserLatLng() async {
    final locationResult = await Location.instance.getLocation();
    return LatLng(
        locationResult.latitude ?? 0.0, locationResult.longitude ?? 0.0);
  }
}
