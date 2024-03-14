import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/assets.dart';
import '../../../constant/color.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/shimmer_effect.dart';
import '../bloc/story_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        title: const Center(
          child: Text(
            "Story App",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1)).then((_) {
            context.read<StoryBloc>().add(StoryAllFetched());
          });
        },
        child: BlocBuilder<StoryBloc, StoryState>(
          buildWhen: (previous, current) =>
              previous.allStoryData != current.allStoryData ||
              previous.stateStatus != current.stateStatus,
          builder: (context, state) {
            switch (state.stateStatus) {
              case StoryStateStatus.initial:
                context.read<StoryBloc>().add(StoryAllFetched());
                return _loadingWidget();
              case StoryStateStatus.loading:
                return _loadingWidget();
              case StoryStateStatus.success:
                return _listStoryCard(state);
              case StoryStateStatus.failure:
                return _errorWidget(state.message);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBlue,
        onPressed: () {
          context.pushNamed(AppRouteConstants.postStoryRoute);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listStoryCard(StoryState state) {
    return ListView.builder(
      itemCount: state.allStoryData.listStory.length,
      itemBuilder: (context, index) {
        final allStory = state.allStoryData.listStory;
        return _storyCard(
          name: allStory[index].name,
          imageUrl: allStory[index].photoUrl,
          onTap: () {
            context.pushNamed(AppRouteConstants.detailStoryRoute,
                pathParameters: {"id": allStory[index].id});
          },
        );
      },
    );
  }

  Widget _storyCard(
      {required String name,
      required String imageUrl,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                      name,
                      style: const TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    )
                  ],
                ),
                const Text(
                  "27 Desember 2024",
                  style: TextStyle(
                    color: Color(0xff524B6B),
                    fontSize: 12,
                  ),
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
              imageUrl: imageUrl,
              placeholder: (_, __) => const GlobalShimmerEffect(
                  horizontalMargin: 0, height: 280, width: double.infinity),
              errorWidget: (_, __, ___) => Image.asset(
                placeholderImagePath,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 280,
              ),
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalShimmerEffect(height: 20, width: 170),
          GlobalShimmerEffect(height: 280, width: double.infinity),
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
