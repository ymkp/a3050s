import 'package:a3050s/features/app/models/media_model.dart';
import 'package:a3050s/features/search/apis/media_search_api.dart';

class MediaSearchRepository {
  final api = MediaSearchAPI();
  Future<List<MediaModel>> searchSong(String term) async {
    return api.searchSong(term);
  }
}
