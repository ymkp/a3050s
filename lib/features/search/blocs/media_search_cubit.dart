import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/search/repositories/media_search_repository.dart';
import 'package:a3050s/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_search_state.dart';
part 'media_search_cubit.freezed.dart';

class MediaSearchCubit extends Cubit<MediaSearchState> {
  MediaSearchCubit(this.mediaSearchRepo)
      : super(
          const MediaSearchState.none(),
          // const MediaSearchState.success(
          //   results: [
          //     MediaModel(
          //       artistId: 0,
          //       collectionId: 0,
          //       trackId: 0,
          //       wrapperType: 'track',
          //       kind: 'kind',
          //       artistName: 'artistName',
          //       collectionName: 'collectionName',
          //       trackName: 'trackName',
          //       collectionArtistId: 1,
          //       collectionArtistName: 'collectionArtistName',
          //       artistViewUrl:
          //           'https://music.apple.com/id/artist/gambino/1510768210?uo=4',
          //       trackViewUrl:
          //           'https://music.apple.com/id/album/costa-rica/1492062725?i=1492062887&uo=4',
          //       previewUrl:
          //           'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/10/b1/e6/10b1e6b4-3375-199a-7181-d9e8e3891d48/mzaf_14246450030236475622.plus.aac.p.m4a',
          //       artworkUrl100:
          //           'https://is1-ssl.mzstatic.com/image/thumb/Music123/v4/ff/da/8b/ffda8b16-de20-df46-7043-1ba454112725/859736078094_cover.jpg/100x100bb.jpg',
          //       collectionPrice: 5000,
          //       trackPrice: 5000,
          //       releaseDate: '2019-12-03T12:00:00Z',
          //       collectionExplicitness: 'notExplicit',
          //       trackExplicitness: 'explicit',
          //       primaryGenreName: 'Hip-Hop/Rap',
          //       country: 'IDN',
          //       trackTimeMillis: 0,
          //       currency: 'IDR',
          //     )
          //   ],
          // ),
        );
  final MediaSearchRepository mediaSearchRepo;

  Future<void> searchSong(String term) async {
    try {
      emit(const MediaSearchState.loading());
      final results = await mediaSearchRepo.searchSong(term);
      emit(MediaSearchState.success(results: results));
    } catch (err, stk) {
      logIt.error('err', stackTrace: stk, error: err);
      emit(MediaSearchState.failed(errorMsg: err.toString()));
    }
  }
}
