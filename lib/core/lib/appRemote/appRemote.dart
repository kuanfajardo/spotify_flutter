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

  SpotifyAppRemote._({this.configuration, this.logLevel});

  static Future<SpotifyAppRemote> initialize({
    SpotifyConfiguration configuration,
    SpotifyAppRemoteLogLevel logLevel = SpotifyAppRemoteLogLevel.none,
    connectionParams
  }) async {
    SpotifyAppRemote appRemote = SpotifyAppRemote._(
        configuration: configuration,
        logLevel: logLevel
    );

    Map<String, dynamic> args = {
      AppRemoteKeys.configuration: configuration.encode(),
      AppRemoteKeys.logLevel: logLevel.index,
      AppRemoteKeys.connectionParams: connectionParams != null
          ? connectionParams.encode()
          : null
    };
    await invokeMethod<void>(AppRemoteMethods.initializeAppRemote, args);
    return appRemote;
  }

  static Future<bool> checkIfSpotifyAppIsActive() {
    return invokeMethod<bool>(AppRemoteMethods.checkIfSpotifyAppIsActive);
  }

  static Future<int> version() {
    return invokeMethod<int>(AppRemoteMethods.version);
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
class SpotifyAppRemoteConnectionParams implements Codec {
  // IMMUTABLE, NOT REAL-TIME;
  final String accessToken;
  final CodecableSize defaultImageSize;
  final SpotifyAppRemoteConnectionParamsImageFormat imageFormat;

  // Readonly, set by SDK, not user
  final int protocolVersion;
  // final Map roles; TODO
  // final List authenticationMethods; TODO

  SpotifyAppRemoteConnectionParams._from(Map<String, dynamic> codecResult) :
        accessToken = codecResult[AppRemoteKeys.accessToken],
        defaultImageSize = CodecableSize.from(codecResult[AppRemoteKeys.defaultImageSize]),
        imageFormat = SpotifyAppRemoteConnectionParamsImageFormat.values[codecResult[AppRemoteKeys.imageFormat]],
        protocolVersion = codecResult[AppRemoteKeys.protocolVersion] ?? -1;

  @override
  Map<String, dynamic> encode() {
    return {
      AppRemoteKeys.accessToken: this.accessToken,
      AppRemoteKeys.defaultImageSize: this.defaultImageSize.encode(),
      AppRemoteKeys.imageFormat: this.imageFormat,
    };
  }

  static SpotifyAppRemoteConnectionParams from(Map<String, dynamic> codecResult) {
    return SpotifyAppRemoteConnectionParams._from(codecResult);
  }
}

class SpotifyAuthorizationParameters implements Codec {
  final String accessToken;
  final String errorDescription;

  SpotifyAuthorizationParameters._from(Map<String, dynamic> codecResult) :
        accessToken = codecResult[AppRemoteKeys.accessToken],
        errorDescription = codecResult[AppRemoteKeys.errorDescription];

  @override
  Map<String, dynamic> encode() {
    return {
      AppRemoteKeys.accessToken: this.accessToken,
      AppRemoteKeys.errorDescription: this.errorDescription,
    };
  }

  static SpotifyAuthorizationParameters from(Map<String, dynamic>codecResult) {
    return SpotifyAuthorizationParameters._from(codecResult);
  }
}
