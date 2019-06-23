import 'dart:async';

import 'package:flutter/services.dart';

class Spotify {
  static const MethodChannel _channel =
      const MethodChannel('spotify');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
