import 'package:a3050s/features/app/widgets/customs/custom_cached_image_container.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/features/media_player/models/position_data.dart';
import 'package:a3050s/features/media_player/widgets/audio_playlist_control_buttons.dart';
import 'package:a3050s/features/media_player/widgets/seek_bar.dart';
import 'package:a3050s/features/search/blocs/media_search_cubit.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:a3050s/utils/helpers/toast_helper.dart';
import 'package:a3050s/utils/methods/aliases.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaPlayerBottomSheet extends StatelessWidget {
  const MediaPlayerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MPAudioCubit, MPAudioState>(
      builder: (context, state) {
        if (state.playlist.isEmpty) {
          return const SizedBox();
        } else {
          final media = state.playlist[state.currentIdx];
          final artworkUrl =
              media.artworkUrl100?.replaceAll('100x100', '500x500') ?? '';
          logIt.info(artworkUrl);
          final foregroundC = $constants
                  .palette.genreColor[media.primaryGenreName.toLowerCase()] ??
              $constants.palette.grey;
          final containerColor = Color.alphaBlend(
            foregroundC,
            $constants.palette.black,
          );

          return Container(
            // height: 700,
            // height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              // color: containerColor,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  foregroundC.withOpacity(0.6),
                  containerColor,
                  $constants.palette.black,
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ? buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'PLAYING FROM SEARCH RESULTS',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            '"${context.read<MediaSearchCubit>().lastSearchTerm}" in search',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                        // showDialog<void>(
                        //   context: context,
                        //   builder: (context) => Dialog(
                        //     child: MediaExternalDialog(
                        //       artistName: media.artistName,
                        //       artworkUrl: media.artworkUrl100 ?? '',
                        //       collectionName: media.collectionName ?? '',
                        //       externalUrl: media.trackViewUrl,
                        //       price: '${media.currency} ${media.trackPrice}',
                        //       trackName: media.trackName,
                        //     ),
                        //   ),
                        // );
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // ? img

                CustomCachedImageContainer(
                  imageURL:
                      media.artworkUrl100?.replaceAll('100x100', '400x400') ??
                          '',
                  width: 400,
                  height: 400,
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                media.trackName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 18),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5,
                                children: [
                                  if (media.trackExplicitness == 'explicit')
                                    const Icon(
                                      Icons.explicit,
                                      size: 18,
                                    ),
                                  Text(
                                    media.artistName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ToastHelper.warning('soon');
                          },
                          iconSize: 30,
                          icon: (2 + 3 == 2)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                        )
                      ],
                    ),
                    // ? seeker & control panel
                    StreamBuilder<PositionData>(
                      stream: context.read<MPAudioCubit>().positionDataStream,
                      builder: (context, snapshot) {
                        return SeekBar(
                          duration: snapshot.data?.duration ?? Duration.zero,
                          position: snapshot.data?.position ?? Duration.zero,
                          bufferedPosition:
                              snapshot.data?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: context.read<MPAudioCubit>().seek,
                        );
                      },
                    ),
                    const AudioPlaylistControlButtons(size: 1.6)
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        }
      },
    );
  }
}
