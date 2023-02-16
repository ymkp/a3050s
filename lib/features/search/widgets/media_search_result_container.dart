import 'package:a3050s/features/app/widgets/media/media_card.dart';
import 'package:a3050s/features/media_player/blocs/mp_audio_cubit.dart';
import 'package:a3050s/features/search/blocs/media_search_cubit.dart';
import 'package:a3050s/modules/dependency_injection/di.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaSearchResultContainer extends StatelessWidget {
  const MediaSearchResultContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaSearchCubit, MediaSearchState>(
      builder: (context, state) => state.when(
        none: () => const Center(
          key: Key('__src_none__'),
          child: Text('Start a search'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        success: (results) => results.isNotEmpty
            ? ListView.builder(
                itemCount: results.length,
                shrinkWrap: true,
                itemBuilder: (context, idx) {
                  return MediaCard(
                    media: results[idx],
                    onTap: () {
                      context
                          .read<MPAudioCubit>()
                          .overwritePlaylistAndPlay(results[idx]);
                      // logIt.info(results[idx].artistName);
                    },
                  );
                },
              )
            : const Center(child: Text('e')),
        failed: (s) => Center(child: Text(s)),
      ),
    );
  }
}
