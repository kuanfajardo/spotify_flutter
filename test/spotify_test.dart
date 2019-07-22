import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotify/spotify.dart';

void main() {
  const MethodChannel channel = MethodChannel('spotify');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
