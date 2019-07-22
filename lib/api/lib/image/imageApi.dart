import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/utils/utils.dart';

import 'package:spotify/api/lib/image/methods.dart' as ImageMethods;
import 'package:spotify/api/lib/image/keys.dart' as ImageKeys;

// Caller
class SpotifyImageAPI {
  Future<CodecableImage> fetchImageForItem(SpotifyImageRepresentable
  imageItem, {CodecableSize size}) {
    Map<String, dynamic> args = {
      ImageKeys.imageItem: imageItem.encode(),
      ImageKeys.size: size.encode()
    };

    return invokeMethod<CodecableImage>(ImageMethods.fetchImageForItem, args);
  }
}

class SpotifyImageRepresentable implements Codec {
  final String imageIdentifier;

  SpotifyImageRepresentable._from(Map<String, dynamic> codecResult) :
      imageIdentifier = codecResult[ImageKeys.imageIdentifier];

  @override
  Map<String, dynamic> encode() {
    return {
      ImageKeys.imageIdentifier: this.imageIdentifier,
    };
  }

  static SpotifyImageRepresentable from(Map<String, dynamic> codecResult) {
    return SpotifyImageRepresentable._from(codecResult);
  }
}