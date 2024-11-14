import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_podcast/podcast_player_view.dart';
import 'audio_player_cubit.dart';

void main() {
  runApp(const PodcastApp());
}

class PodcastApp extends StatelessWidget {
  const PodcastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podcast Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AudioPlayerCubit()..loadPodcast("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        child: const PodcastPlayerView(),
      ),
    );
  }
}
