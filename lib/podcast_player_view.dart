import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_podcast/audio_player_cubit.dart';
import 'package:flutter_podcast/audio_player_state.dart';


class PodcastPlayerView extends StatelessWidget {
  const PodcastPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AudioPlayerCubit()..loadPodcast("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Podcast Player"),
        ),
        body: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, state) {
            final cubit = context.read<AudioPlayerCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Podcast Player",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: state.currentPosition,
                  max: state.duration,
                  onChanged: (value) {
                    state.player.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${state.currentPosition.toStringAsFixed(0)}s"),
                    Text("${state.duration.toStringAsFixed(0)}s"),
                  ],
                ),
                IconButton(
                  icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 64.0,
                  onPressed: cubit.playPause,
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 64.0,
                  onPressed: cubit.stop,
                ),
                if (state.loading) const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
