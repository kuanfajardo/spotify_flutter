import 'dart:ui' show Size;

import 'package:spotify/api/api.dart';
import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/utils/utils.dart';

import 'package:spotify/core/lib/session/session.dart';

import 'package:spotify/core/lib/appRemote/methods.dart' as AppRemoteMethods;
import 'package:spotify/core/lib/appRemote/keys.dart' as AppRemoteKeys;

enum SpotifyAppRemoteLogLevel { none, debug, info, error, }

// Caller
class SpotifyAppRemote {
  final SpotifyConfiguration configuration;
  final SpotifyAppRemoteLogLevel logLevel;

  final SpotifyPlayerAPI playerAPI = SpotifyPlayerAPI();
  final SpotifyImageAPI imageAPI = SpotifyImageAPI();
  final SpotifyUserAPI userAPI = SpotifyUserAPI();
  final SpotifyContentAPI contentAPI = SpotifyContentAPI();

  SpotifyAppRemoteDelegate delegate;

  SpotifyAppRemote({this.configuration, this.logLevel,
    connectionParams}) {
    Map<String, dynamic> args = {
      AppRemoteKeys.configuration: configuration.encode(),
      AppRemoteKeys.logLevel: logLevel,
      AppRemoteKeys.connectionParams: connectionParams.encode()
    };
    invokeMethod(AppRemoteMethods.initializeAppRemote, args);
  }

  static Future<bool> checkIfSpotifyAppIsActive() {
    return invokeMethod<bool>(AppRemoteMethods.checkIfSpotifyAppIsActive);
  }

  static Future<String> version() {
    return invokeMethod<String>(AppRemoteMethods.version);
  }

  static Future<int> spotifyItunesItemIdentifier() {
    return invokeMethod<int>(AppRemoteMethods.spotifyItunesItemIdentifier);
  }

  Future<SpotifyAppRemoteConnectionParams> get connectionParameters {
    return invokeMethod<SpotifyAppRemoteConnectionParams>(AppRemoteMethods.connectionParameters);
  }

  Future<bool> get isConnected {
    return invokeMethod<bool>(AppRemoteMethods.isConnected);
  }

  Future<void> connect() {
    return invokeMethod(AppRemoteMethods.connect);
  }

  Future<void> disconnect() {
    return invokeMethod(AppRemoteMethods.disconnect);
  }

  Future<bool> authorizeAndPlayUri(String uri) {
    return invokeMethod(AppRemoteMethods.authorizeAndPlayUri, uri);
  }

  Future<SpotifyAuthorizationParameters> authorizationParametersFromURL(Uri url) {
    return invokeMethod<SpotifyAuthorizationParameters>(AppRemoteMethods.authorizationParametersFromURL, url.toString());
  }
}

abstract class SpotifyAppRemoteDelegate {
  void spotifyDidEstablishConnection([SpotifyAppRemote spotify]);
  void spotifyDidFailConnectionAttemptWithException(Exception e, [SpotifyAppRemote
  spotify]);
  void spotifyDidDisconnectWithException(Exception e, [SpotifyAppRemote spotify]);
}

enum SpotifyAppRemoteConnectionParamsImageFormat { any, jpeg, png, }

// Caller?
class SpotifyAppRemoteConnectionParams implements Codecable {
  // IMMUTABLE, NOT REAL-TIME;
  final String accessToken;
  final Size defaultImageSize;
  final SpotifyAppRemoteConnectionParamsImageFormat imageFormat;

  // Readonly, set by SDK, not user
  final int protocolVersion;
  // final Map roles; TODO
  // final List authenticationMethods; TODO

  SpotifyAppRemoteConnectionParams({this.accessToken, this.defaultImageSize,
    this.imageFormat, this.protocolVersion = -1});

  @override
  Map<String, dynamic> encode() {
    CodecableSize codecableDefaultImageSize = CodecableSize.from(this.defaultImageSize);
    return {
      AppRemoteKeys.accessToken: this.accessToken,
      AppRemoteKeys.defaultImageSize: codecableDefaultImageSize.encode(),
      AppRemoteKeys.imageFormat: this.imageFormat,
    };
  }

  static SpotifyAppRemoteConnectionParams decode(Map<String, dynamic> codecResult) {
    Map<String, dynamic> rawDefaultImageSize = codecResult[AppRemoteKeys.defaultImageSize];
    int imageFormatIndex = codecResult[AppRemoteKeys.imageFormat];

    return SpotifyAppRemoteConnectionParams(
      accessToken: codecResult[AppRemoteKeys.accessToken],
      defaultImageSize: Decoder.instance.decode
      <CodecableSize>(rawDefaultImageSize),
      imageFormat: SpotifyAppRemoteConnectionParamsImageFormat.values[imageFormatIndex],
      protocolVersion: codecResult[AppRemoteKeys.protocolVersion],
    );
  }
}

class SpotifyAuthorizationParameters implements Codecable {
  final String accessToken;
  final String errorDescription;

  SpotifyAuthorizationParameters(this.accessToken, {this.errorDescription});

  @override
  Map<String, dynamic> encode() {
    return {
      AppRemoteKeys.accessToken: this.accessToken,
      AppRemoteKeys.errorDescription: this.errorDescription,
    };
  }

  static SpotifyAuthorizationParameters decode(Map<String, dynamic>
  codecResult) {
    return SpotifyAuthorizationParameters(
      codecResult[AppRemoteKeys.accessToken],
      errorDescription: codecResult[AppRemoteKeys.errorDescription],
    );
  }
}
