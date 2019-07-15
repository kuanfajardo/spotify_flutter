import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/model/model.dart';

import 'package:spotify/api/lib/content/methods.dart' as ContentMethods;
import 'package:spotify/api/lib/content/keys.dart' as ContentKeys;

enum SpotifyContentType { default_, navigation, fitness, }

// Caller
class SpotifyContentAPI {
  Future<List<SpotifyContentItem>> fetchRootContentItemsForType(SpotifyContentType
  contentType) {
    return invokeListMethod<SpotifyContentItem>(ContentMethods
        .fetchRootContentItemsForType, contentType);
  }

  Future<List<SpotifyContentItem>> fetchChildrenOfContentItem(SpotifyContentItem contentItem) {
    return invokeListMethod<SpotifyContentItem>(ContentMethods
        .fetchChildrenOfContentItem, contentItem);
  }

  Future<List<SpotifyContentItem>> fetchRecommendedContentItemsForType(SpotifyContentType contentType,
      {bool flattenContainers = true}) {
    Map<String, dynamic> args = {
      ContentKeys.contentType: contentType,
      ContentKeys.flattenContainers: flattenContainers,
    };

    return invokeListMethod<SpotifyContentItem>(ContentMethods
        .fetchRecommendedContentItemsForType, args);
  }
}
