import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_app/features/common/utils/common.dart';
import 'package:story_app/features/location/cubit/location_cubit.dart';

import '../../../constant/color.dart';
import '../../location/utils/location_error_dialog.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _PostStoryPaidState();
}

class _PostStoryPaidState extends State<SelectLocationScreen> {
  final initialPosition = const LatLng(-6.175392, 106.827153);
  late GoogleMapController _mapController;
  LatLng? userLatLngLocation;
  String? userAddresLocation;
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
              userLatLngLocation = latLngUser;
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
                userLatLngLocation = latLngUser;
                onMoveNewPosition(latLngUser);
              },
            ),
            _boxSelectButtonComp(
              onSelectLocation: () async {
                if (userLatLngLocation != null) {
                  context.pop([userLatLngLocation, userAddresLocation]);
                }
              },
            )
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

  Widget _boxSelectButtonComp({required VoidCallback onSelectLocation}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 175,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 18),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.labelPickLocation,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: onSelectLocation,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      minimumSize: Size.zero,
                      fixedSize: const Size(90, 90),
                      shape: const CircleBorder()),
                  child: Text(
                    AppLocalizations.of(context)!.labelButtonPickLocation,
                    style: const TextStyle(color: Colors.white),
                  ))
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
    userLatLngLocation = latLng;
    userAddresLocation = address;
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
