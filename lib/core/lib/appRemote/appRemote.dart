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

  SpotifyAppRemoteConnectionParams _connectionParams;
  SpotifyAppRemoteConnectionParams get connectionParams => _connectionParams;

  final SpotifyPlayerAPI _playerAPI = SpotifyPlayerAPI();
  final SpotifyImageAPI _imageAPI = SpotifyImageAPI();
  final SpotifyUserAPI _userAPI = SpotifyUserAPI();
  final SpotifyContentAPI _contentAPI = SpotifyContentAPI();

  bool isConnected;

  SpotifyPlayerAPI get playerAPI => isConnected ? _playerAPI : null;
  SpotifyImageAPI get imageAPI => isConnected ? _imageAPI : null;
  SpotifyUserAPI get userAPI => isConnected ? _userAPI : null;
  SpotifyContentAPI get contentAPI => isConnected ? _contentAPI : null;

  SpotifyAppRemote._({this.configuration, this.logLevel,
    SpotifyAppRemoteConnectionParams connectionParams}) : _connectionParams = connectionParams;

  static Future<SpotifyAppRemote> initialize({
    SpotifyConfiguration configuration,
    SpotifyAppRemoteLogLevel logLevel = SpotifyAppRemoteLogLevel.none,
    SpotifyAppRemoteConnectionParams connectionParams
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
    appRemote._connectionParams = await
    invokeMethod<SpotifyAppRemoteConnectionParams>(AppRemoteMethods.initializeAppRemote, args);

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

enum SpotifyAppRemoteConnectionParamsImageFormat { any, jpeg, png, }

// Caller?
class SpotifyAppRemoteConnectionParams implements Codec {
  String accessToken;

  // IMMUTABLE, NOT REAL-TIME;
  final CodecableSize defaultImageSize;
  final SpotifyAppRemoteConnectionParamsImageFormat imageFormat;

  // Readonly, set by SDK, not user
  int _protocolVersion;
  int get protocolVersion => _protocolVersion;

  // final Map roles; TODO (like version)
  // final List authenticationMethods; TODO (like version)

  SpotifyAppRemoteConnectionParams({this.accessToken, this.defaultImageSize,
    this.imageFormat});

  SpotifyAppRemoteConnectionParams._from(Map<String, dynamic> codecResult) :
        accessToken = codecResult[AppRemoteKeys.accessToken],
        defaultImageSize = CodecableSize.from(codecResult[AppRemoteKeys.defaultImageSize]),
        imageFormat = SpotifyAppRemoteConnectionParamsImageFormat.values[codecResult[AppRemoteKeys.imageFormat]],
        _protocolVersion = codecResult[AppRemoteKeys.protocolVersion] ?? -1;

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
