import 'dart:typed_data';

import 'package:spotify/encoding/encoding.dart';

const String kWidth = 'width';
const String kHeight = 'height';

const String kImageData = 'imageData';

class CodecableSize implements FlutterChannelCodable {
  final double width;
  final double height;

  CodecableSize._from(Map<String, dynamic> channelObject) :
        width = channelObject[kWidth],
        height = channelObject[kHeight];

  @override
  Map<String, dynamic> encode() {
    return {
      kWidth: this.width,
      kHeight: this.height,
    };
  }

  static CodecableSize from(Map<String, dynamic> channelObject) {
    return CodecableSize._from(channelObject);
  }
}

class DecodableImage implements FlutterChannelDecodable {
  final Uint8List imageData;

  DecodableImage._from(Map<String, dynamic> channelObject) :
        imageData = channelObject[kImageData];

  static DecodableImage from(Map<String, dynamic> channelObject) {
    return DecodableImage._from(channelObject);
  }
}