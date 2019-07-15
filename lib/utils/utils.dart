import 'dart:ui' show Size;
import 'dart:typed_data';

import 'package:flutter/widgets.dart' show Image;

import 'package:spotify/encoding/encoding.dart';

const String kWidth = 'width';
const String kHeight = 'height';

const String kImageData = 'imageData';

class CodecableSize extends Size implements Codec {
  CodecableSize(Size size) : super(size.width, size.height);

  @override
  Map<String, dynamic> encode() {
    return {
      kWidth: this.width,
      kHeight: this.height,
    };
  }

  static Size from(Map<String, dynamic> codecResult) {
    double width = codecResult[kWidth];
    double height = codecResult[kHeight];
    return Size(width, height);
  }
}

class CodecableImage extends Image implements Decodable {
  static Image from(Map<String, dynamic> codecResult) {
    Uint8List imageData = codecResult[kImageData];
    return Image.memory(imageData);
  }
}