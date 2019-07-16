import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/core/lib/session/methods.dart' as SessionMethods;
import 'package:spotify/core/lib/session/keys.dart' as SessionKeys;


/// See https://developer.spotify.com/web-api/using-scopes/
enum SpotifyScope {
  playlistReadPrivate,
  playlistReadCollaborative,
  playlistModifyPublic,
  playlistModifyPrivate,
  userFollowRead,
  userFollowModify,
  userLibraryRead,
  userLibraryModify,
  userReadBirthDate,
  userReadEmail,
  userReadPrivate,
  userTopRead,
  ugcImageUpload,
  streaming,
  appRemoteControl,
  userReadPlaybackState,
  userModifyPlaybackState,
  userReadCurrentlyPlaying,
  userReadRecentlyPlayed,
}

enum SpotifyAuthorizationOptions { default_, client, }

class SpotifySession implements Decodable {
  final String accessToken;
  final String refreshToken;
  final DateTime expirationDate;
  final SpotifyScope scope;
  final bool isExpired;

  SpotifySession._from(Map<String, dynamic> codecResult) :
      accessToken = codecResult[SessionKeys.]

  static SpotifySession from(Map<String, dynamic> codecResult) {
    return SpotifySession._from(codecResult);
  }
}

// Caller
class SpotifySessionManager {
  final SpotifyConfiguration configuration;

  Future<SpotifySession> get session {
    return invokeMethod<SpotifySession>(SessionMethods.session);
  }
  
  SpotifySessionManagerDelegate delegate;

//  bool alwaysShowAuthorizationDialog;

  SpotifySessionManager(this.configuration) {
    invokeMethod(SessionMethods.initializeSessionManager, configuration.encode());
  }

  Future<bool> isSpotifyAppInstalled() {
    return invokeMethod<bool>(SessionMethods.isSpotifyAppInstalled);
  }

  Future<void> initiateSessionWithScope(SpotifyScope scope,
      {SpotifyAuthorizationOptions options = SpotifyAuthorizationOptions
          .default_ }) {
    Map<String, dynamic> args = {
      SessionKeys.scope: scope,
      SessionKeys.scope: options,
    };
    return invokeMethod(SessionMethods.initiateSessionWithScope, args);
  }

  Future<void> renewSession() {
    return invokeMethod(SessionMethods.renewSession);
  }
// openURL
}

abstract class SpotifySessionManagerDelegate {
  void sessionManagerDidInitiateSession(SpotifySession session,
      [SpotifySessionManager sessionManager]);
  void sessionManagerDidFailWithException(Exception e,
      [SpotifySessionManager sessionManager]);
  // Optional
  void sessionManagerDidRenewSession(SpotifySession session,
      [SpotifySessionManager sessionManager]) {}
  // Optional
  void sessionManagerShouldRequestAccessTokenWithAuthorizationCode
      (String authorizationCode,  [SpotifySessionManager sessionManager]) {}
}

class SpotifyConfiguration implements Codec {
  final String clientId;
  final Uri redirectUrl;
  Uri tokenSwapUrl;
  Uri tokenRefreshUrl;
  String playUri;

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
      SessionKeys.redirectUrl: this.redirectUrl,
      SessionKeys.tokenSwapUrl: this.tokenSwapUrl,
      SessionKeys.tokenRefreshUrl: this.tokenRefreshUrl,
      SessionKeys.playUri: this.playUri,
    };
  }

  static SpotifyConfiguration from(Map<String, dynamic> codecResult) {
    return SpotifyConfiguration._from(codecResult);
  }
}
