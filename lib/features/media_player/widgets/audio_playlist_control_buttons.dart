import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlaylistControlButtons extends StatelessWidget {
  const AudioPlaylistControlButtons({
    super.key,
    this.size = 1,
  });

  final double size;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MPAudioCubit, MPAudioState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: context.read<MPAudioCubit>().hasPrevious
                  ? () async => context.read<MPAudioCubit>().seekToPrevious()
                  : null,
              disabledColor: $constants.palette.grey,
              color: $constants.palette.white,
              iconSize: 30 * size,
              icon: const Icon(Icons.skip_previous),
            ),
            state.status.maybeWhen(
              // buffering: () => const CircularProgressIndicator(),
              // loading: () => const CircularProgressIndicator(),
              ready: () => IconButton(
                iconSize: 30 * size,
                disabledColor: $constants.palette.grey,
                color: $constants.palette.white,
                icon: const Icon(Icons.play_arrow),
                onPressed: () async => context.read<MPAudioCubit>().play(),
              ),
              completed: () => IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 30 * size,
                disabledColor: $constants.palette.grey,
                color: $constants.palette.white,
                onPressed: () async =>
                    context.read<MPAudioCubit>().seekToStart(),
              ),
              playing: () => IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 30 * size,
                disabledColor: $constants.palette.grey,
                color: $constants.palette.white,
                onPressed: () async => context.read<MPAudioCubit>().pause(),
              ),
              orElse: () => IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 30 * size,
                disabledColor: $constants.palette.white,
                color: $constants.palette.white,
                onPressed: null,
              ),
            ),
            IconButton(
              onPressed: context.read<MPAudioCubit>().hasNext
                  ? () async => context.read<MPAudioCubit>().seekToNext()
                  : null,
              disabledColor: $constants.palette.grey,
              color: $constants.palette.white,
              iconSize: 30 * size,
              icon: const Icon(Icons.skip_next),
            ),
          ],
        );
      },
    );
  }
}
