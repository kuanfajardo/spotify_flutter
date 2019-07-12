import 'dart:ui' show Size;
import 'dart:typed_data';

import 'package:flutter/widgets.dart' show Image;

import 'package:spotify/encoding/encoding.dart';

const String kWidth = 'width';
const String kHeight = 'height';

class CodecableSize extends Size implements Codecable {
  CodecableSize({double width, double height}) : super(width, height);

  CodecableSize.from(Size size) : super(size.width, size.height);

  @override
  Map<String, dynamic> encode() {
    return {
      kWidth: this.width,
      kHeight: this.height,
    };
  }

  static Size decode(Map<String, dynamic> codecResult) {
    double width = codecResult[kWidth];
    double height = codecResult[kHeight];
    return Size(width, height);
  }
}

const String kImageData = 'imageData';

class CodecableImage extends Image implements Codecable {
  @override
  Map<String, dynamic> encode() {
    return null; // Method not necessary, as image will only go from
    // native -> dart, not dart -> native
  }

  static Image decode(Map<String, dynamic> codecResult) {
    Uint8List imageData = codecResult[kImageData];
    return Image.memory(imageData);
  }
}