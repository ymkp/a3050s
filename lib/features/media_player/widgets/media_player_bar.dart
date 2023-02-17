import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/features/media_player/models/position_data.dart';
import 'package:a3050s/features/media_player/widgets/media_player_bottom_sheet.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:a3050s/utils/helpers/toast_helper.dart';

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

          return InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                useSafeArea: true,
                context: context,
                isScrollControlled: true,
                builder: (context) => const MediaPlayerBottomSheet(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: containerColor,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                                  // Text(
                                  //   media.kind,
                                  //   style:
                                  //       Theme.of(context).textTheme.labelMedium,
                                  // ),
                                  Text(
                                    media.artistName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 42,
                              height: 42,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    ToastHelper.warning('soon');
                                  },
                                  icon: (2 + 3 == 2)
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_border),
                                ),
                              ),
                            ),
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
                                    onPressed: () async => context
                                        .read<MPAudioCubit>()
                                        .seekToStart(),
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
                      ],
                    ),
                  ),
                  StreamBuilder<PositionData>(
                    stream: context.read<MPAudioCubit>().positionDataStream,
                    builder: (context, snapshot) {
                      final position =
                          snapshot.data?.position.inMilliseconds ?? 0;
                      final duration =
                          snapshot.data?.duration.inMilliseconds ?? 1;
                      if (snapshot.hasData) {}
                      return Container(
                        height: 3,
                        color: $constants.palette.white,
                        width: duration == 0
                            ? 0
                            : MediaQuery.of(context).size.width *
                                position /
                                duration,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
