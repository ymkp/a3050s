import 'package:a3050s/features/app/widgets/media/media_card.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/features/search/blocs/media_search_cubit.dart';

import 'package:a3050s/features/search/blocs/recently_played_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentlyPlayedContainer extends StatelessWidget {
  const RecentlyPlayedContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyPlayedCubit, RecentlyPlayedState>(
      builder: (context, state) => state.playlist.isEmpty
          ? const Center(
              child: Text('What do you want to listen to?'),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Recently Played',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.playlist.length,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return MediaCard(
                        media: state.playlist[idx],
                        onRemoveTap: () {
                          context
                              .read<RecentlyPlayedCubit>()
                              .removeRecentlyPlayed(idx);
                        },
                        onTap: () {
                          context.read<MPAudioCubit>().overwritePlaylistAndPlay(
                                playlist: state.playlist,
                                index: idx,
                              );
                          context
                              .read<MediaSearchCubit>()
                              .setTermToRecentlyPlayed();
                          context
                              .read<RecentlyPlayedCubit>()
                              .addRecentlyPlayed(state.playlist[idx]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
