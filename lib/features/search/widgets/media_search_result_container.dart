import 'package:a3050s/features/app/widgets/media/media_card.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';

import 'package:a3050s/features/search/blocs/media_search_cubit.dart';
import 'package:a3050s/features/search/blocs/recently_played_cubit.dart';
import 'package:a3050s/features/search/widgets/recently_played_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaSearchResultContainer extends StatelessWidget {
  const MediaSearchResultContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaSearchCubit, MediaSearchState>(
      builder: (context, state) => state.when(
        none: () => const RecentlyPlayedContainer(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        success: (results) => results.isNotEmpty
            ? BlocBuilder<MPAudioCubit, MPAudioState>(
                builder: (context, audioState) => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: results.length,
                  shrinkWrap: true,
                  itemBuilder: (context, idx) {
                    return MediaCard(
                      media: results[idx],
                      // isOnPlay: results[idx].trackId ==
                      //     context.read<MPAudioCubit>().onPlay?.trackId,
                      isOnPlay: audioState.status.maybeWhen(
                        playing: () =>
                            audioState.playlist.isNotEmpty &&
                            results[idx].trackId ==
                                audioState
                                    .playlist[audioState.currentIdx].trackId,
                        orElse: () => false,
                      ),
                      onTap: () {
                        context.read<MPAudioCubit>().overwritePlaylistAndPlay(
                              playlist: results,
                              index: idx,
                            );
                        context
                            .read<RecentlyPlayedCubit>()
                            .addRecentlyPlayed(results[idx]);
                        // logIt.info(results[idx].artistName);
                      },
                    );
                  },
                ),
              )
            : const Center(child: Text('No items found')),
        failed: (s) => Center(child: Text(s)),
      ),
    );
  }
}
