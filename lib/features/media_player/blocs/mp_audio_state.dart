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
        status: MPAudioStateStatus.none(),
      );
}

@freezed
class MPAudioStateStatus with _$MPAudioStateStatus {
  const factory MPAudioStateStatus.none() = _None;
  const factory MPAudioStateStatus.loading() = _Loading;
  const factory MPAudioStateStatus.playing() = _Playing;
  const factory MPAudioStateStatus.completed() = _Completed;
  const factory MPAudioStateStatus.error() = _Error;
}
