part of 'media_search_cubit.dart';

@freezed
class MediaSearchState with _$MediaSearchState {
  const factory MediaSearchState.none() = _None;
  const factory MediaSearchState.success({
    required List<MediaModel> results,
  }) = _OK;
  const factory MediaSearchState.loading() = _Loading;
  const factory MediaSearchState.failed({required String errorMsg}) = _Error;
}
