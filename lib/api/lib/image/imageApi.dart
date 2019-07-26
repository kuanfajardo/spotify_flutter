import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/utils/utils.dart';

import 'package:spotify/api/lib/image/methods.dart' as ImageMethods;
import 'package:spotify/api/lib/image/keys.dart' as ImageKeys;

// Caller
class SpotifyImageAPI {
  Future<DecodableImage> fetchImageForItem(SpotifyImageRepresentable
  imageItem, {CodecableSize size}) {
    Map<String, dynamic> args = {
      ImageKeys.imageItem: imageItem.encode(),
      ImageKeys.size: size.encode()
    };

    return invokeMethod<DecodableImage>(ImageMethods.fetchImageForItem, args);
  }
}

class SpotifyImageRepresentable implements FlutterChannelCodable {
  final String imageIdentifier;

  SpotifyImageRepresentable._from(Map<String, dynamic> channelObject) :
      imageIdentifier = channelObject[ImageKeys.imageIdentifier];

  @override
  Map<String, dynamic> encode() {
    return {
      ImageKeys.imageIdentifier: this.imageIdentifier,
    };
  }

  static SpotifyImageRepresentable from(Map<String, dynamic> channelObject) {
    return SpotifyImageRepresentable._from(channelObject);
  }
}