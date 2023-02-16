import 'dart:async';

import 'package:a3050s/features/app/models/media_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

part 'mp_audio_state.dart';
part 'mp_audio_cubit.freezed.dart';

@lazySingleton
class MPAudioCubit extends Cubit<MPAudioState> {
  MPAudioCubit() : super(MPAudioState.init()) {
    init();
  }

  StreamSubscription? _audioStatusSub;
  StreamSubscription? _indexSub;
  StreamSubscription? _songStateSub;

  final AudioPlayer _audioPlayer = AudioPlayer();

  void init() {
    _audioStatusSub?.cancel();
    _audioStatusSub = _audioPlayer.playerStateStream.listen(
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
    _indexSub = _audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          emit(state.copyWith(currentIdx: index));
        }
      },
    );

    _songStateSub?.cancel();
    // _songStateSub = songCubit.stream.listen(
    //   (songState) {
    //     songState.status.maybeWhen(
    //       success: () async {
    //         if (state.playList.isEmpty) {
    //           await loadPlayList(playList: songState.songs);
    //           emit(state.copyWith(playList: songState.songs));
    //           _canReloadPlayList = false;
    //         } else {
    //           _canReloadPlayList = true;
    //         }
    //         return;
    //       },
    //       orElse: () {},
    //     );
    //   },
    // );
  }

  Future<void> loadPlayList({
    required List<MediaModel> playList,
    int index = 0,
  }) async {
    emit(state.copyWith(playlist: playList));
    try {
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: playList
              .map((song) => AudioSource.uri(Uri.parse(song.previewUrl!)))
              .toList(),
        ),
        initialIndex: index,
      );
    } catch (_) {
      emit(state.copyWith(status: const MPAudioStateStatus.failure()));
    }
    return;
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> seekToNext() async {
    if (_audioPlayer.hasNext) {
      await _audioPlayer.seekToNext();
    }
  }

  Future<void> seekToPrevious() async {
    if (_audioPlayer.hasPrevious) {
      await _audioPlayer.seekToPrevious();
    }
  }

  Future<void> seekToStart() async {
    await _audioPlayer.seek(
      Duration.zero,
      index: _audioPlayer.effectiveIndices?.first,
    );
  }

  Future<void> seekToIndex({
    required int index,
    List<MediaModel> playList = const [],
  }) async {
    if (playList.isNotEmpty) {
      // reload new playlist and play the song@index
      emit(state.copyWith(playlist: playList));
      await loadPlayList(playList: playList, index: index);
      await _audioPlayer.play();
    } else {
      // seek to a particular song@index with zero duration, and then play it
      await _audioPlayer.seek(Duration.zero, index: index);
      await _audioPlayer.play();
    }
    return;
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    _audioStatusSub?.cancel();
    _indexSub?.cancel();
    _songStateSub?.cancel();
    return super.close();
  }

  Future<void> overwritePlaylistAndPlay(MediaModel media) async {
    await loadPlayList(playList: [media]);
    await play();
    // emit(
    //   MPAudioState(
    //     playlist: [media],
    //     currentIdx: 0,
    //     status: const MPAudioStateStatus.idle(),
    //   ),
    // );
  }
}
