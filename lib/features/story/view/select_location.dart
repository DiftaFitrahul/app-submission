import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constant/color.dart';
import '../../../utils/y_alignment_custom_sliding_up.dart';
import '../../common/utils/common.dart';
import '../../location/cubit/location_cubit.dart';
import '../../location/utils/location_error_dialog.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _PostStoryPaidState();
}

class _PostStoryPaidState extends State<SelectLocationScreen> {
  final initialPosition = const LatLng(-6.175392, 106.827153);
  final ValueNotifier<double> boxSelectPostionedListener =
      ValueNotifier<double>(1);
  late GoogleMapController _mapController;
  LatLng? userSelectLatLngLocation;
  String? userSelectAddresLocation;
  final Set<Marker> _markers = {};

  @override
  void didChangeDependencies() {
    context.read<LocationCubit>().requestGPS();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, GPSPermisson>(
        listener: (context, state) async {
          switch (state) {
            case GPSPermisson.denied:
              LocationErrorDialog.gpsDeniedDialog(
                context: context,
                onPressed: () {
                  context.read<LocationCubit>().requestGPS();
                  context.pop();
                },
              );
              break;
            case GPSPermisson.permanentlyDenied:
              LocationErrorDialog.gpsPermanentlyDeniedDialog(
                context: context,
                onPressed: () {
                  openAppSettings();
                  context.pop();
                },
              );
              break;
            case GPSPermisson.success:
              LatLng latLngUser =
                  await context.read<LocationCubit>().getUserLatLng();
              userSelectLatLngLocation = latLngUser;
              onMoveNewPosition(latLngUser);
              break;
            default:
              break;
          }
        },
        child: Stack(
          children: [
            _googleMapsComp(
              onLongPress: (latLng) {
                onMoveNewPosition(latLng);
              },
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
            ),
            _backButtonComp(
              onPressed: () {
                context.pop();
                context.read<LocationCubit>().endGPSPermission();
              },
            ),
            _myLocationButtonComp(
              onPressed: () async {
                LatLng latLngUser =
                    await context.read<LocationCubit>().getUserLatLng();
                userSelectLatLngLocation = latLngUser;
                onMoveNewPosition(latLngUser);
              },
            ),
            ValueListenableBuilder(
                valueListenable: boxSelectPostionedListener,
                builder: (context, yPositioned, _) {
                  return _boxSelectButtonComp(
                    screenHeight: MediaQuery.sizeOf(context).height,
                    yPositioned: yPositioned,
                    onSelectLocation: () async {
                      if (userSelectLatLngLocation != null) {
                        context.pop([
                          userSelectLatLngLocation,
                          userSelectAddresLocation
                        ]);
                      }
                    },
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _googleMapsComp(
      {required void Function(LatLng)? onLongPress,
      required void Function(GoogleMapController)? onMapCreated}) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 16,
      ),
      onLongPress: onLongPress,
      onMapCreated: onMapCreated,
      markers: _markers,
      myLocationEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
    );
  }

  Widget _backButtonComp({required VoidCallback onPressed}) {
    return Align(
      alignment: const Alignment(-0.89, -0.87),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            elevation: 4,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          )),
    );
  }

  Widget _myLocationButtonComp({required VoidCallback onPressed}) {
    return Align(
      alignment: const Alignment(0.89, -0.87),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            elevation: 4,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(10),
          ),
          child: const Icon(
            Icons.my_location_rounded,
            color: Colors.black,
          )),
    );
  }

  Widget _boxSelectButtonComp(
      {required double yPositioned,
      required VoidCallback onSelectLocation,
      required double screenHeight}) {
    return AnimatedAlign(
      duration: Durations.medium1,
      alignment: Alignment(0, yPositioned),
      curve: Curves.easeIn,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy > 0) {
            boxSelectPostionedListener.value = 1;
          }
          if (details.delta.dy < 0) {
            boxSelectPostionedListener.value =
                yAlignmentPickLocationSlidingUp(screenHeight);
          }
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(1, 1),
                    blurRadius: 4,
                    spreadRadius: 2)
              ],
              color: const Color.fromARGB(255, 248, 248, 255),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                height: 5,
                margin: const EdgeInsets.only(top: 10, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
              ),
              Text(
                AppLocalizations.of(context)!.labelPickLocation,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                    onPressed: onSelectLocation,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        minimumSize: Size.zero,
                        fixedSize: const Size(90, 90),
                        shape: const CircleBorder()),
                    child: Text(
                      AppLocalizations.of(context)!.labelButtonPickLocation,
                      style: const TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onMoveNewPosition(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    defineMarker(latLng, street ?? "", address);
    userSelectLatLngLocation = latLng;
    userSelectAddresLocation = address;
    _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      _markers.clear();
      _markers.add(marker);
    });
  }
}
