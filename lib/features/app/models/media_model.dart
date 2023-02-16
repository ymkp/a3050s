import 'package:freezed_annotation/freezed_annotation.dart';
part 'media_model.freezed.dart';
part 'media_model.g.dart';

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required int artistId,
    int? collectionId,
    required int trackId,
    required String wrapperType,
    required String kind,
    required String artistName,
    required String? collectionName,
    required String trackName,
    int? collectionArtistId,
    String? collectionArtistName,
    required String artistViewUrl,
    required String trackViewUrl,
    required String? previewUrl,
    String? artworkUrl100,
    num? collectionPrice,
    num? trackPrice,
    required String releaseDate,
    required String collectionExplicitness,
    required String trackExplicitness,
    required String primaryGenreName,
    required String country,
    required String currency,
    int? trackTimeMillis,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
}
// ? wrapperType : track, collection, artist
// ? explicit : explicit, cleaned, notExplicit
// ? kind : book, album, coached-audio, feature-movie, interactive- booklet, music-video, pdf podcast, podcast-episode, software-package, song, tv- episode, artist 
