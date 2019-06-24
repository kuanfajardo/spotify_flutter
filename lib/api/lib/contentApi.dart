import 'package:spotify/core/core.dart';

enum SpotifyContentType { default_, navigation, fitness, }

abstract class SpotifyContentAPI {
  Future fetchRootContentItemsForType(SpotifyContentType contentType);
  Future fetchChildrenOfContentItem(SpotifyContentItem contentItem);
  Future fetchRecommendedContentItemsForType(SpotifyContentType contentType,
      {bool flattenContainers});
}
