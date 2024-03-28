import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GPSPermisson {
  initial,
  requesting,
  success,
  denied,
  permanentlyDenied,
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
}
