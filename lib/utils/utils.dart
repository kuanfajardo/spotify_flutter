import 'dart:typed_data';

import 'package:spotify/encoding/encoding.dart';

const String kWidth = 'width';
const String kHeight = 'height';

const String kImageData = 'imageData';

class CodecableSize implements Codec {
  final double width;
  final double height;

  CodecableSize(this.width, this.height);

  @override
  Map<String, dynamic> encode() {
    return {
      kWidth: this.width,
      kHeight: this.height,
    };
  }

  static CodecableSize from(Map<String, dynamic> codecResult) {
    double width = codecResult[kWidth];
    double height = codecResult[kHeight];
    return CodecableSize(width, height);
  }
}

class CodecableImage implements Decodable {
  final Uint8List imageData;

  CodecableImage(this.imageData);

  static CodecableImage from(Map<String, dynamic> codecResult) {
    Uint8List imageData = codecResult[kImageData];
    return CodecableImage(imageData);
  }
}