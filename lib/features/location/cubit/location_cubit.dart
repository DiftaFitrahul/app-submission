import 'package:permission_handler/permission_handler.dart';
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
    final status = await Permission.location.request();
    if (status == PermissionStatus.permanentlyDenied) {
      emit(GPSPermisson.permanentlyDenied);
    } else if (status == PermissionStatus.denied) {
      emit(GPSPermisson.denied);
    } else {
      emit(GPSPermisson.success);
    }
  }
}
