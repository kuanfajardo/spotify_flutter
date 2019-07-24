import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/core/lib/session/methods.dart' as SessionMethods;
import 'package:spotify/core/lib/session/keys.dart' as SessionKeys;


/// See https://developer.spotify.com/web-api/using-scopes/
class SpotifyScope implements Codec {
  final int bitmask;

  SpotifyScope(this.bitmask);

  SpotifyScope operator |(SpotifyScope scope) {
    return SpotifyScope(this.bitmask | scope.bitmask);
  }

  const SpotifyScope._internal(this.bitmask);

  static const playlistReadPrivate = const SpotifyScope._internal(1 << 0);
  static const playlistReadCollaborative = const SpotifyScope._internal(1 <<
      1);
  static const playlistModifyPublic = const SpotifyScope._internal(1 << 2);
  static const playlistModifyPrivate = const SpotifyScope._internal(1 << 3);
  static const userFollowRead = const SpotifyScope._internal(1 << 4);
  static const userFollowModify = const SpotifyScope._internal(1 << 5);
  static const userLibraryRead = const SpotifyScope._internal(1 << 6);
  static const userLibraryModify = const SpotifyScope._internal(1 << 7);
  static const userReadBirthDate = const SpotifyScope._internal(1 << 8);
  static const userReadEmail = const SpotifyScope._internal(1 << 9);
  static const userReadPrivate = const SpotifyScope._internal(1 << 10);
  static const userTopRead = const SpotifyScope._internal(1 << 11);
  static const ugcImageUpload = const SpotifyScope._internal(1 << 12);
  static const streaming = const SpotifyScope._internal(1 << 13);
  static const appRemoteControl = const SpotifyScope._internal(1 << 14);
  static const userReadPlaybackState = const SpotifyScope._internal(1 << 15);
  static const userModifyPlaybackState = const SpotifyScope._internal(1 << 16);
  static const userReadCurrentlyPlaying = const SpotifyScope._internal(1 <<
      17);
  static const userReadRecentlyPlayed = const SpotifyScope._internal(1 << 18);

  // Codec
  @override
  Map<String, dynamic> encode() {
    return { SessionKeys.bitmask: this.bitmask };
  }

  SpotifyScope._from(Map<String, dynamic> codecResult) :
        this.bitmask = codecResult[SessionKeys.bitmask];

  static SpotifyScope from(Map<String, dynamic> codecResult) {
    return SpotifyScope._from(codecResult);
  }
}

enum SpotifyAuthorizationOptions { default_, client, }

class SpotifySession implements Decodable {
  final String accessToken;
  final String refreshToken;
//  final DateTime expirationDate;
  final SpotifyScope scope;
  final bool isExpired;

  SpotifySession._from(Map<String, dynamic> codecResult) :
        accessToken = codecResult[SessionKeys.accessToken],
        refreshToken = codecResult[SessionKeys.refreshToken],
//        expirationDate = TODO
        scope = codecResult[SessionKeys.scope],
        isExpired = codecResult[SessionKeys.isExpired];

  static SpotifySession from(Map<String, dynamic> codecResult) {
    return SpotifySession._from(codecResult);
  }
}

// Caller
class SpotifySessionManager {
  final SpotifyConfiguration configuration;

  SpotifySession session;

//  bool alwaysShowAuthorizationDialog;

  SpotifySessionManager._(this.configuration);

  static Future<SpotifySessionManager> initialize(SpotifyConfiguration
  configuration) async {
    SpotifySessionManager sessionManager = SpotifySessionManager._
      (configuration);
    await invokeMethod<void>(SessionMethods.initializeSessionManager,
        configuration.encode());
    return sessionManager;
  }

  Future<bool> isSpotifyAppInstalled() {
    return invokeMethod<bool>(SessionMethods.isSpotifyAppInstalled);
  }

  Future<void> initiateSessionWithScope(SpotifyScope scope,
      {SpotifyAuthorizationOptions options = SpotifyAuthorizationOptions
          .default_ }) {
    Map<String, dynamic> args = {
      SessionKeys.scope: scope.encode(),
      SessionKeys.options: options.index,
    };
    print(args);
    return invokeMethod(SessionMethods.initiateSessionWithScope, args);
  }

  Future<void> renewSession() {
    return invokeMethod(SessionMethods.renewSession);
  }
}

class SpotifyConfiguration implements Codec {
  final String clientId;
  final Uri redirectUrl;
  Uri tokenSwapUrl;
  Uri tokenRefreshUrl;
  String playUri;

  SpotifyConfiguration({this.clientId, this.redirectUrl});

  SpotifyConfiguration._from(Map<String, dynamic> codecResult) :
        clientId = codecResult[SessionKeys.clientId],
        redirectUrl = Uri.dataFromString(codecResult[SessionKeys.redirectUrl]),
        tokenSwapUrl = Uri.dataFromString(codecResult[SessionKeys.tokenSwapUrl]),
        tokenRefreshUrl = Uri.dataFromString(codecResult[SessionKeys.tokenRefreshUrl]),
        playUri = codecResult[SessionKeys.playUri];

  @override
  Map<String, dynamic> encode() {
    return {
      SessionKeys.clientId: this.clientId,
      SessionKeys.redirectUrl: this.redirectUrl.toString(),
      SessionKeys.tokenSwapUrl: this.tokenSwapUrl.toString(),
      SessionKeys.tokenRefreshUrl: this.tokenRefreshUrl.toString(),
      SessionKeys.playUri: this.playUri,
    };
  }

  static SpotifyConfiguration from(Map<String, dynamic> codecResult) {
    return SpotifyConfiguration._from(codecResult);
  }
}
