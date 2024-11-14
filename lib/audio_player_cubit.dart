import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_podcast/audio_player_state.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerState(player: AudioPlayer()));

  Future<void> loadPodcast(String url) async {
    emit(state.copyWith(loading: true));
    try {
      await state.player.setUrl(url);
      final duration = state.player.duration?.inSeconds.toDouble() ?? 0;
      emit(state.copyWith(duration: duration, loading: false));
      _listenToPositionUpdates();
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _listenToPositionUpdates() {
    state.player.positionStream.listen((position) {
      emit(state.copyWith(currentPosition: position.inSeconds.toDouble()));
    });
  }

  Future<void> playPause() async {
    if (state.isPlaying) {
      emit(state.copyWith(isPlaying: false));
      await state.player.pause();
    } else {
      emit(state.copyWith(isPlaying: true));
      await state.player.play();

    }
    
  }

  Future<void> stop() async {
    await state.player.stop();
    await state.player.seek(const Duration(seconds: 0));
    emit(state.copyWith(isPlaying: false, currentPosition: 0));
  }

  @override
  Future<void> close() {
    state.player.dispose();
    return super.close();
  }
}
