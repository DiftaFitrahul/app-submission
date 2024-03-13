import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/story/bloc/story_bloc.dart';
import 'package:story_app/features/story/data/model/story_data.dart';

import '../../../constant/color.dart';

class DetailStoryScreen extends StatelessWidget {
  const DetailStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 248, 255),
          title: const Center(
            child: Text("Detail Story"),
          )),
      body: BlocBuilder<StoryBloc, StoryState>(
        buildWhen: (previous, current) =>
            previous.detailStoryData != current.detailStoryData ||
            previous.stateDetailStatus != current.stateDetailStatus,
        builder: (context, state) {
          switch (state.stateDetailStatus) {
            case DetailStoryStateStatus.initial:
              return const CircularProgressIndicator();
            case DetailStoryStateStatus.loading:
              return const CircularProgressIndicator();
            case DetailStoryStateStatus.success:
              return _successWidget(state.detailStoryData.story);
            case DetailStoryStateStatus.failure:
              return Text(state.message);
          }
        },
      ),
    );
  }

  Widget _successWidget(StoryData storyData) {
    return Column(
      children: [
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
                style: const TextStyle(color: Color(0xff524B6B), fontSize: 12),
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
        Text(storyData.description),
        const SizedBox(height: 60)
      ],
    );
  }
}
