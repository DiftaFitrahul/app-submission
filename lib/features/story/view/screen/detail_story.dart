import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_app/app_config.dart';
import 'package:story_app/features/location/cubit/location_cubit.dart';
import 'package:story_app/features/location/utils/location_error_dialog.dart';
import 'package:story_app/utils/date_time_formater.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/utils/global_dialog.dart';

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
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController controller;
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        title: const Text(
          "Detail Story",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1)).then((_) {
            context.read<StoryBloc>().add(StoryDetailFetched(id: widget.id));
          });
        },
        child: BlocListener<LocationCubit, GPSPermisson>(
          listener: (context, state) {
            switch (state) {
              case GPSPermisson.initial:
                break;
              case GPSPermisson.requesting:
                log("Requesting GPS");

                context.read<LocationCubit>().requestGPS();
                break;
              case GPSPermisson.denied:
                LocationErrorDialog.gpsDeniedDialog(
                  context: context,
                  onPressed: () {
                    context.read<LocationCubit>().requestGPS();
                    Navigator.pop(context);
                  },
                );
                break;
              case GPSPermisson.permanentlyDenied:
                LocationErrorDialog.gpsPermanentlyDeniedDialog(
                  context: context,
                  onPressed: () {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                );
                break;
              case GPSPermisson.success:
                break;
            }
          },
          child: _dummyWidget(),
        ),
        // child: BlocBuilder<StoryBloc, StoryState>(
        //   buildWhen: (previous, current) =>
        //       previous.detailStoryData != current.detailStoryData ||
        //       previous.stateDetailStatus != current.stateDetailStatus,
        //   builder: (context, state) {
        //     switch (state.stateDetailStatus) {
        //       case DetailStoryStateStatus.initial:
        //         return _loadingWidget();
        //       case DetailStoryStateStatus.loading:
        //         return _loadingWidget();
        //       case DetailStoryStateStatus.success:
        //         return _successWidget(state.detailStoryData.story);
        //       case DetailStoryStateStatus.failure:
        //         return _dummyWidget();
        //       // return _errorWidget(context, state.message);
        //     }
        //   },
        // ),
      ),
    );
  }

  Widget _dummyWidget() {
    return Stack(
      children: [
        // GoogleMap(
        //   myLocationEnabled: true,
        // ),
        Column(
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
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 7),
                      Text(
                        AppConfig.shared.title,
                        style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )
                    ],
                  ),
                  Builder(builder: (context) {
                    return const Text(
                      "12-12-2024",
                      style: TextStyle(color: Color(0xff524B6B), fontSize: 12),
                    );
                  })
                ],
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                height: 280,
                width: double.infinity,
                fit: BoxFit.fill,
                imageUrl:
                    "https://media.hitekno.com/thumbs/2022/05/31/82987-one-piece-luffy/730x480-img-82987-one-piece-luffy.jpg",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Luffy adalah seorang raja bajak laut yang sangat disukai banyak orang, dia selalu menolong orang di manapun di berada. Ambisi besar dia untuk menjadi raja bajak lau terlihat meskipun perjalan masih jauh tapi proses itu ada dan nyata",
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
        ListView()
      ],
    );
  }

  Widget _successWidget(StoryData storyData) {
    return Stack(
      children: [
        Column(
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
                      dateTimeFormater(storyData.createdAt,
                          context.watch<CommonCubit>().state.languageCode),
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
                height: 280,
                width: double.infinity,
                fit: BoxFit.fill,
                imageUrl: storyData.photoUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                storyData.description,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
        ListView()
      ],
    );
  }

  Widget _loadingWidget() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (_, __) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalShimmerEffect(height: 20, width: 170),
          GlobalShimmerEffect(height: 280, width: double.infinity),
          GlobalShimmerEffect(
            height: 20,
            width: 200,
            horizontalMargin: 5,
          ),
          GlobalShimmerEffect(
            height: 20,
            width: 210,
            horizontalMargin: 5,
          ),
          GlobalShimmerEffect(
            height: 20,
            width: 230,
            horizontalMargin: 5,
          ),
          GlobalShimmerEffect(
            height: 20,
            width: 250,
            horizontalMargin: 5,
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }

  Widget _errorWidget(BuildContext context, String message) {
    return Stack(
      children: [
        Center(
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
        ListView()
      ],
    );
  }
}
