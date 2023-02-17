import 'package:a3050s/features/app/models/media_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'recently_played_state.dart';
part 'recently_played_cubit.freezed.dart';

class RecentlyPlayedCubit extends HydratedCubit<RecentlyPlayedState> {
  RecentlyPlayedCubit() : super(const RecentlyPlayedState(playlist: []));

  void removeRecentlyPlayed(int index) {
    final playlist = state.playlist.toList();
    if (index < playlist.length) {
      playlist.removeAt(index);
      emit(state.copyWith(playlist: playlist));
    }
  }

  void addRecentlyPlayed(MediaModel media) {
    final playlist = state.playlist.toList();
    final idx = playlist.indexWhere((e) => e.trackId == media.trackId);
    if (idx == -1) {
      playlist.add(media);
      emit(state.copyWith(playlist: playlist));
    }
  }

  @override
  RecentlyPlayedState fromJson(Map<String, dynamic> json) {
    final playlist = json['recently_played'] == null
        ? <MediaModel>[]
        : (json['recently_played'] as List)
            .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
            .toList();
    return RecentlyPlayedState(playlist: playlist);
  }

  @override
  Map<String, dynamic> toJson(RecentlyPlayedState state) =>
      {'recently_played': state.playlist};
}
