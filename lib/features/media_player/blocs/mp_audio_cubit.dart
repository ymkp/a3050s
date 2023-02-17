import 'dart:async';

import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/media_player/models/position_data.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

part 'mp_audio_state.dart';
part 'mp_audio_cubit.freezed.dart';

@lazySingleton
class MPAudioCubit extends Cubit<MPAudioState> {
  MPAudioCubit() : super(MPAudioState.init()) {
    init();
  }

  StreamSubscription<PlayerState>? _audioStatusSub;
  StreamSubscription<int?>? _indexSub;

  final AudioPlayer _player = AudioPlayer();

  bool get hasPrevious => _player.hasPrevious;
  bool get hasNext => _player.hasNext;

  MediaModel? get onPlay => _onPlay();

  MediaModel? _onPlay() {
    if (state.playlist.isEmpty) return null;
    return state.playlist.elementAt(state.currentIdx);
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  void init() {
    _audioStatusSub?.cancel();
    _audioStatusSub = _player.playerStateStream.listen(
      (playerState) {
        final processingState = playerState.processingState;
        switch (processingState) {
          case ProcessingState.idle:
            emit(state.copyWith(status: const MPAudioStateStatus.idle()));
            break;
          case ProcessingState.loading:
            emit(state.copyWith(status: const MPAudioStateStatus.loading()));
            break;
          case ProcessingState.buffering:
            emit(state.copyWith(status: const MPAudioStateStatus.buffering()));
            break;
          case ProcessingState.ready:
            playerState.playing
                ? emit(
                    state.copyWith(status: const MPAudioStateStatus.playing()),
                  )
                : emit(
                    state.copyWith(status: const MPAudioStateStatus.ready()),
                  );
            break;
          case ProcessingState.completed:
            emit(state.copyWith(status: const MPAudioStateStatus.completed()));
            break;
          default:
            emit(state.copyWith(status: const MPAudioStateStatus.idle()));
            break;
        }
      },
    );

    _indexSub?.cancel();
    _indexSub = _player.currentIndexStream.listen(
      (index) {
        if (index != null) {
          emit(state.copyWith(currentIdx: index));
        }
      },
    );
  }

  Future<void> loadPlayList({
    required List<MediaModel> playlist,
    int index = 0,
  }) async {
    logIt.warn('playlist : ${playlist.length}, index : $index');
    emit(state.copyWith(playlist: playlist));
    try {
      await _player.setAudioSource(
        ConcatenatingAudioSource(
          children: playlist
              .map(
                (song) => AudioSource.uri(
                  Uri.parse(
                    song.previewUrl!,
                    // .replaceAll('https', 'http'),
                  ),
                ),
              )
              .toList(),
        ),
        initialIndex: index,
      );
    } catch (err, st) {
      logIt.error('err', error: err, stackTrace: st);
      emit(state.copyWith(status: const MPAudioStateStatus.failure()));
    }
    return;
  }

  Future<void> seek(Duration? position, {int? index}) async {
    await _player.seek(position, index: index);
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> seekToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
    }
  }

  Future<void> seekToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
    }
  }

  Future<void> seekToStart() async {
    await _player.seek(
      Duration.zero,
      index: _player.effectiveIndices?.first,
    );
  }

  Future<void> seekToIndex({
    required int index,
    List<MediaModel> playlist = const [],
  }) async {
    if (playlist.isNotEmpty) {
      // reload new playlist and play the song@index
      emit(state.copyWith(playlist: playlist));
      await loadPlayList(playlist: playlist, index: index);
      await _player.play();
    } else {
      // seek to a particular song@index with zero duration, and then play it
      await _player.seek(Duration.zero, index: index);
      await _player.play();
    }
    return;
  }

  @override
  Future<void> close() {
    _player.dispose();
    _audioStatusSub?.cancel();
    _indexSub?.cancel();
    return super.close();
  }

  Future<void> overwritePlaylistAndPlay({
    required List<MediaModel> playlist,
    required int index,
  }) async {
    await loadPlayList(playlist: playlist, index: index);
    await play();
  }
}
