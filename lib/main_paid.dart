import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:story_app/app_config.dart';
import 'package:story_app/main_app.dart';
import 'package:story_app/features/user/shared/data/repository/user_repository.dart';
import 'package:story_app/features/story/data/data_source/story_data_source.dart';
import 'package:story_app/features/story/data/repository/story_repository.dart';
import 'package:story_app/features/user/shared/data/data_source/auth_data_source.dart';
import 'package:story_app/features/user/shared/data/data_source/local_data.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';

void main() {
  AppConfig.create(
    title: "Story App Plus",
    flavor: Flavor.paid,
  );

  const authDataSource = AuthDataSource();
  const localDataSource = LocalDataSource();
  const storyDataSource = StoryDataSource();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MainApp(
      authRepository: AuthRepositoryImp(
          authDataSource: authDataSource, localDataSorce: localDataSource),
      storyRepository: StoryRepositoryImp(
          localDataSource: localDataSource, storyDataSource: storyDataSource),
      userRepository: UserRepositoryImp(localDataSorce: localDataSource),
    ),
  ));
}
