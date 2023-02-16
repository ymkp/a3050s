part of 'mp_audio_cubit.dart';

@freezed
class MPAudioState with _$MPAudioState {
  const factory MPAudioState({
    required List<MediaModel> playlist,
    required int currentIdx,
    required MPAudioStateStatus status,
  }) = _MPAudioState;

  factory MPAudioState.init() => const MPAudioState(
        playlist: [],
        currentIdx: 0,
        status: MPAudioStateStatus.idle(),
      );
}

@freezed
class MPAudioStateStatus with _$MPAudioStateStatus {
  const factory MPAudioStateStatus.idle() = _Idle;
  const factory MPAudioStateStatus.loading() = _Loading;
  const factory MPAudioStateStatus.buffering() = _Buffering;
  const factory MPAudioStateStatus.ready() = _Ready;
  const factory MPAudioStateStatus.playing() = _Playing;
  const factory MPAudioStateStatus.completed() = _Completed;
  const factory MPAudioStateStatus.failure() = _Failure;
}
