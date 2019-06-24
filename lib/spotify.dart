import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:spotify/api/api.dart';
import 'package:spotify/core/core.dart';

// Core
class Spotify {
  static const MethodChannel _channel =
      const MethodChannel('spotify');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // Start
  final SpotifyConfiguration configuration;
  final SpotifyLogLevel logLevel;
  final SpotifyConnectionParams connectionParams;


  Spotify({this.configuration, this.logLevel,
      this.connectionParams});

  // TODO: get's?
  static Future<bool> checkIfSpotifyAppIsActive();
  static String version();
  static int spotifyItunesItemIdentifier();

  bool get isConnected;
  Spotify delegate;

  void connect();
  void disconnect();
  bool authorizeAndPlayUri(String uri);
  Map<String, String> authorizationParametersFromURL(Uri url);

  SpotifyPlayerAPI get playerAPI;
  SpotifyImageAPI get imageAPI;
  SpotifyUserAPI get userAPI;
  SpotifyContentAPI get contentAPI;
}
abstract class SpotifyDelegate {
  void spotifyDidEstablishConnection([Spotify spotify]);
  void spotifyDidFailConnectionAttemptWithException(Exception e, [Spotify
  spotify]);
  void spotifyDidDisconnectWithException(Exception e, [Spotify spotify]);
}

const String kSpotifyAccessTokenKey = ""; // TODO
const String kSpotifyErrorDescriptionKey = ""; // TODO

enum SpotifyLogLevel { none, debug, info, error, }

class SpotifyConnectionParams {
  String accessToken;
  Size defaultImageSize;
  SpotifyConnectionParamsImageFormat imageFormat;
  int get protocolVersion => 0; // TODO
  Map get roles => {}; // TODO
  List get authenticationRoles => [];

  SpotifyConnectionParams({this.accessToken, this.defaultImageSize,
    this.imageFormat});
}
enum SpotifyConnectionParamsImageFormat { any, jpeg, png, }

// TODO: Uri's -> objects
// TODO: Future<bool> necessary bool?
