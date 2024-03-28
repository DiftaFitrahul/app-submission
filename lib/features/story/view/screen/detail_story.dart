import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_app/constant/assets.dart';
import 'package:story_app/features/common/utils/common.dart';
import 'package:story_app/features/location/cubit/location_cubit.dart';
import 'package:story_app/features/location/utils/location_error_dialog.dart';
import 'package:story_app/utils/date_time_formater.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../../../../constant/color.dart';
import '../../../../utils/server_client_failure_msg.dart';
import '../../../../utils/shimmer_effect.dart';
import '../../../common/cubit/common_cubit.dart';
import '../../bloc/story_bloc.dart';
import '../../data/model/story_data.dart';

class DetailStoryScreen extends StatefulWidget {
  const DetailStoryScreen({super.key, required this.id});
  final String id;

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  final initialPosition = const LatLng(-6.175392, 106.827153);
  late GoogleMapController mapController;

  late final Set<Marker> markers = {};

  geo.Placemark? placemark;

  @override
  void didChangeDependencies() {
    context.read<LocationCubit>().requestGPS();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LocationCubit, GPSPermisson>(
      listener: (context, state) {
        switch (state) {
          case GPSPermisson.initial:
            break;
          case GPSPermisson.requesting:
            context.read<LocationCubit>().requestGPS();
            break;
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
            break;
        }
      },
      child: BlocBuilder<StoryBloc, StoryState>(
          buildWhen: (previous, current) =>
              previous.detailStoryData != current.detailStoryData ||
              previous.stateDetailStatus != current.stateDetailStatus,
          builder: (context, state) {
            switch (state.stateDetailStatus) {
              case DetailStoryStateStatus.initial:
                return _loadingWidget();
              case DetailStoryStateStatus.loading:
                return _loadingWidget();
              case DetailStoryStateStatus.success:
                return _successWidget(context, state.detailStoryData.story);
              case DetailStoryStateStatus.failure:
                return _errorWidget(context, state.message);
            }
          }),
    ));
  }

  Widget _successWidget(BuildContext context, StoryData storyData) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: initialPosition,
          ),
          onMapCreated: (controller) async {
            setState(() {
              mapController = controller;
            });
            if (storyData.lat != null && storyData.lon != null) {
              onMoveNewPosition(LatLng(storyData.lat ?? 0, storyData.lon ?? 0));
            }
          },
          markers: markers,
          myLocationEnabled: false,
          compassEnabled: false,
          zoomControlsEnabled: false,
        ),
        if (storyData.lat == null && storyData.lon == null)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: double.infinity,
              color: Colors.black.withOpacity(0.2),
              child: Align(
                alignment: const Alignment(0, -0.4),
                child: Text(
                  AppLocalizations.of(context)!.labelTextLocationNotAvailable,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        Align(
          alignment: const Alignment(-0.89, -0.87),
          child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.03),
                onTap: () {
                  if (storyData.lat != null && storyData.lon != null) {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target:
                                LatLng(storyData.lat ?? 0, storyData.lon ?? 0),
                            zoom: 16)));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                  size: 30,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  storyData.name,
                                  style: const TextStyle(
                                      color: darkBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            Builder(builder: (context) {
                              return Text(
                                dateTimeFormater(
                                    storyData.createdAt,
                                    context
                                        .watch<CommonCubit>()
                                        .state
                                        .languageCode),
                                style: const TextStyle(
                                    color: Color(0xff524B6B), fontSize: 12),
                              );
                            })
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          imageUrl: storyData.photoUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Container(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(height: 10),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 3,
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  storyData.description,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadingWidget() {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: Image.asset(
            placeholderMapPath,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15),
                GlobalShimmerEffect(height: 20, width: 170),
                GlobalShimmerEffect(height: 180, width: double.infinity),
                GlobalShimmerEffect(
                  height: 15,
                  width: 200,
                  horizontalMargin: 5,
                ),
                GlobalShimmerEffect(
                  height: 15,
                  width: 210,
                  horizontalMargin: 5,
                ),
                GlobalShimmerEffect(
                  height: 15,
                  width: 210,
                  horizontalMargin: 5,
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _errorWidget(BuildContext context, String message) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: Image.asset(
            placeholderMapPath,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: const Alignment(-0.89, -0.87),
          child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 375,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(
                  height: 5,
                ),
                Text(failureMessage(context, message))
              ],
            ),
          ),
        ),
      ],
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
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
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
      markers.clear();
      markers.add(marker);
    });
  }
}
