import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    required this.player,
    this.isPlaying = false,
    this.currentPosition = 0,
    this.duration = 0,
    this.loading = false,
  });

  final AudioPlayer player;
  final bool isPlaying;
  final double currentPosition;
  final double duration;
  final bool loading;

  bool get isEndOfAudio => currentPosition >= duration - 5;

  @override
  List<Object> get props => [
        player,
        isPlaying,
        currentPosition,
        duration,
        loading,
      ];

  AudioPlayerState copyWith({
    AudioPlayer? player,
    bool? isPlaying,
    double? currentPosition,
    double? duration,
    bool? loading,
  }) {
    return AudioPlayerState(
      player: player ?? this.player,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      duration: duration ?? this.duration,
      loading: loading ?? this.loading,
    );
  }
}
