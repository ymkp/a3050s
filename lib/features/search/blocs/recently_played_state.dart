part of 'recently_played_cubit.dart';

@freezed
class RecentlyPlayedState with _$RecentlyPlayedState {
  const factory RecentlyPlayedState({
    required List<MediaModel> playlist,
  }) = _RecentlyPlayedState;
}
