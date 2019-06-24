import 'dart:ui';

abstract class SpotifyImageAPI {
  Future<Image> fetchImageForItem(SpotifyImageRepresentable imageItem, {Size
  size});
}

abstract class SpotifyImageRepresentable {
  String get imageIdentifier;
}