import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaPlayerBar extends StatelessWidget {
  const MediaPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MPAudioCubit, MPAudioState>(
      builder: (context, state) {
        if (state.playlist.isEmpty) {
          return const SizedBox();
        } else {
          final media = state.playlist[state.currentIdx];
          final foregroundC = $constants
                  .palette.genreColor[media.primaryGenreName.toLowerCase()] ??
              $constants.palette.grey;
          final containerColor = Color.alphaBlend(
            foregroundC.withOpacity(0.32),
            $constants.palette.black,
          );

          return Container(
            decoration: BoxDecoration(
              color: containerColor,
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCachedImageContainer(
                    imageURL: media.artworkUrl100 ?? '',
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          media.trackName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            if (media.trackExplicitness == 'explicit')
                              const Icon(
                                Icons.explicit,
                                size: 15,
                              ),
                            Text(
                              media.kind,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              media.artistName,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 42,
                    height: 42,
                    child: Center(
                      child: state.status.maybeWhen(
                        // buffering: () => const LoadingWidget(),
                        // loading: () => const LoadingWidget(),
                        ready: () => IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: $constants.palette.white,
                          ),
                          onPressed: () async =>
                              context.read<MPAudioCubit>().play(),
                        ),
                        completed: () => IconButton(
                          icon: Icon(
                            Icons.replay,
                            color: $constants.palette.white,
                          ),
                          onPressed: () async =>
                              context.read<MPAudioCubit>().seekToStart(),
                        ),
                        playing: () => IconButton(
                          icon: Icon(
                            Icons.pause,
                            color: $constants.palette.white,
                          ),
                          onPressed: () async =>
                              context.read<MPAudioCubit>().pause(),
                        ),
                        orElse: () => const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
