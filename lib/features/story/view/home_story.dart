import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/constant/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/story/bloc/story_bloc.dart';
import 'package:story_app/routes/routes_name.dart';
// import 'package:go_router/go_router.dart';
// import 'package:story_app/features/user/auth/bloc/auth_bloc.dart';
// import 'package:story_app/routes/routes_name.dart';

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
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
      body: BlocBuilder<StoryBloc, StoryState>(
        buildWhen: (previous, current) =>
            previous.allStoryData != current.allStoryData ||
            previous.stateStatus != current.stateStatus,
        builder: (context, state) {
          switch (state.stateStatus) {
            case StoryStateStatus.initial:
              context.read<StoryBloc>().add(StoryAllFetched());
              return const Center(
                child: CircularProgressIndicator(),
              );

            case StoryStateStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case StoryStateStatus.success:
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

            case StoryStateStatus.failure:
              return const Center(
                child: Text('error occured'),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRouteConstants.postStoryRoute);
        },
        child: const Icon(
          Icons.add,
          color: darkBlue,
        ),
      ),
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
                  style: TextStyle(color: Color(0xff524B6B), fontSize: 12),
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
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
