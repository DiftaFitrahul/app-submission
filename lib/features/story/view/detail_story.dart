import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/color.dart';
import '../../../utils/shimmer_effect.dart';
import '../bloc/story_bloc.dart';
import '../data/model/story_data.dart';

class DetailStoryScreen extends StatelessWidget {
  const DetailStoryScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 248, 255),
          title: const Center(
            child: Text(
              "Detail Story",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1)).then((_) {
            context.read<StoryBloc>().add(StoryDetailFetched(id: id));
          });
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
                return _successWidget(state.detailStoryData.story);
              case DetailStoryStateStatus.failure:
                return _errorWidget(state.message);
            }
          },
        ),
      ),
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
                  Text(
                    DateTime.tryParse(storyData.createdAt).toString(),
                    style:
                        const TextStyle(color: Color(0xff524B6B), fontSize: 12),
                  )
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

  Widget _errorWidget(String message) {
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
              Text(message)
            ],
          ),
        ),
        ListView()
      ],
    );
  }
}
