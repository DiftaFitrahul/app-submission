import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/common/utils/common.dart';
import 'package:story_app/utils/date_time_formater.dart';

import '../../../utils/server_client_failure_msg.dart';
import '../../../constant/assets.dart';
import '../../../constant/color.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/shimmer_effect.dart';
import '../../common/cubit/common_cubit.dart';
import '../bloc/story_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isBottom) context.read<StoryBloc>().add(StoryFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        title: const Text(
          "Story App",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRouteConstants.settingsRoute);
              },
              icon: const Icon(
                Icons.settings,
                color: darkBlue,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1)).then((_) {
            context.read<StoryBloc>().add(StoryRefreshed());
          });
        },
        child: BlocBuilder<StoryBloc, StoryState>(
          buildWhen: (previous, current) =>
              previous.allStoryData.listStory !=
                  current.allStoryData.listStory ||
              previous.stateStatus != current.stateStatus,
          builder: (context, state) {
            switch (state.stateStatus) {
              case StoryStateStatus.initial:
                context.read<StoryBloc>().add(StoryFetched());
                return _loadingWidget();
              case StoryStateStatus.refreshing:
                return _loadingWidget();
              case StoryStateStatus.success:
                return _listStoryCard(context, state);
              case StoryStateStatus.failure:
                return _errorWidget(context, state.message);
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

  Widget _listStoryCard(BuildContext context, StoryState state) {
    return state.allStoryData.listStory.isEmpty
        ? Center(
            child: Text(AppLocalizations.of(context)!.emptyStory),
          )
        : ListView.builder(
            itemCount: state.hasReachedMaxGetStory
                ? state.allStoryData.listStory.length
                : state.allStoryData.listStory.length + 1,
            controller: _scrollController,
            itemBuilder: (context, index) {
              final allStory = state.allStoryData.listStory;
              return index >= state.allStoryData.listStory.length
                  ? _bottomLoader()
                  : _storyCard(
                      name: allStory[index].name,
                      imageUrl: allStory[index].photoUrl,
                      time: allStory[index].createdAt,
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
      required String time,
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
                Builder(builder: (context) {
                  return Text(
                    dateTimeFormater(
                        time, context.watch<CommonCubit>().state.languageCode),
                    style: const TextStyle(
                      color: Color(0xff524B6B),
                      fontSize: 12,
                    ),
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

  Widget _bottomLoader() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
