import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/search/repositories/media_search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_search_state.dart';
part 'media_search_cubit.freezed.dart';

class MediaSearchCubit extends Cubit<MediaSearchState> {
  MediaSearchCubit(this.mediaSearchRepo) : super(const MediaSearchState.none());
  final MediaSearchRepository mediaSearchRepo;

  Future<void> searchSong(String term) async {
    try {
      emit(const MediaSearchState.loading());
      final results = await mediaSearchRepo.searchSong(term);
      emit(MediaSearchState.success(results: results));
    } catch (err) {
      emit(MediaSearchState.failed(errorMsg: err.toString()));
    }
  }
}
