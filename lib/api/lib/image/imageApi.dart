import 'package:flutter/widgets.dart';

import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/utils/utils.dart';

import 'package:spotify/api/lib/image/methods.dart' as ImageMethods;
import 'package:spotify/api/lib/image/keys.dart' as ImageKeys;

// Caller
class SpotifyImageAPI {
  Future<Image> fetchImageForItem(SpotifyImageRepresentable imageItem, {Size
  size}) {
    CodecableSize codecableSize = CodecableSize.from(size);
    Map<String, dynamic> args = {
      ImageKeys.imageItem: imageItem.encode(),
      ImageKeys.size: codecableSize.encode()
    };

    return invokeMethod<CodecableImage>(ImageMethods.fetchImageForItem, args);
  }
}

class SpotifyImageRepresentable implements Codecable {
  final String imageIdentifier;

  SpotifyImageRepresentable(this.imageIdentifier);

  @override
  Map<String, dynamic> encode() {
    return {
      ImageKeys.imageIdentifier: this.imageIdentifier,
    };
  }

  static SpotifyImageRepresentable decode(Map<String, dynamic> codecResult) {
    return SpotifyImageRepresentable(codecResult[ImageKeys.imageIdentifier]);
  }
}