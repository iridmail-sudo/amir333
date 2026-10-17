import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_version.dart';
import 'core/theme.dart';
import 'data/course_repository.dart';
import 'features/home/home_screen.dart';
import 'playback/playback_engine.dart';
import 'playback/simulated_engine.dart';

class Vision2App extends StatelessWidget {
  const Vision2App({super.key, this.repository, this.engineFactory});

  final CourseRepository? repository;
  final PlaybackEngineFactory? engineFactory;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CourseRepository>(
          create: (_) => repository ?? InMemoryCourseRepository.sample(),
        ),
        Provider<PlaybackEngineFactory>.value(
          value: engineFactory ?? () => SimulatedPlaybackEngine(),
        ),
      ],
      child: MaterialApp(
        title: AppVersion.name,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
