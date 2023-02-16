import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/utils/constants.dart';
import 'package:a3050s/utils/methods/aliases.dart';

class MediaSearchAPI {
  Future<List<MediaModel>> searchSong(String term) async {
    final res = await httpClient.get(
      route: 'search',
      query: {
        'term': term,
        'media': 'music',
        'attribute': 'artistTerm',
        'limit': $constants.api.maxItemToBeFetchedAtOneTime,
        'country': 'ID'
      },
    ) as Map<String, dynamic>;
    final arr = (res['results'] is List)
        ? res['results'] as List<dynamic>
        : <Map<String, dynamic>>[];
    final result =
        arr.map((a) => MediaModel.fromJson(a as Map<String, dynamic>)).toList();

    return result
        .where((e) => e.previewUrl != null && e.kind == 'song')
        .toList();
  }
}
