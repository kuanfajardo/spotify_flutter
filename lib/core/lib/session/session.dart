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

class SpotifySession {
  final String _accessToken;
  final String _refreshToken;
  final DateTime _expirationDate;
  final SpotifyScope _scope;
  final bool _isExpired;

  String get accessToken => this._accessToken;
  String get refreshToken => this._refreshToken;
  DateTime get expirationDate => this._expirationDate;
  SpotifyScope get scope => this._scope;
  bool get isExpired => this._isExpired;

  SpotifySession(this._accessToken, this._refreshToken, this._expirationDate,
      this._scope, this._isExpired);
}

// Caller
class SpotifySessionManager {
  final SpotifyConfiguration configuration;

  Future<SpotifySession> get session {
    return invokeMethod(SessionMethods.session);
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

class SpotifyConfiguration implements Codecable {
  final String clientId;
  final Uri redirectUrl;
  Uri tokenSwapUrl;
  Uri tokenRefreshUrl;
  String playUri;

  SpotifyConfiguration({this.clientId, this.redirectUrl, this.tokenSwapUrl,
      this.tokenRefreshUrl, this.playUri});

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

  static SpotifyConfiguration decode(Map<String, dynamic> codecResult) {
    String redirectString = codecResult[SessionKeys.redirectUrl];
    String tokenSwapString = codecResult[SessionKeys.tokenSwapUrl];
    String tokenRefreshString = codecResult[SessionKeys.tokenRefreshUrl];

    return SpotifyConfiguration(
      clientId: codecResult[SessionKeys.clientId],
      redirectUrl: Uri.dataFromString(redirectString),
      tokenSwapUrl: Uri.dataFromString(tokenSwapString),
      tokenRefreshUrl: Uri.dataFromString(tokenRefreshString),
      playUri: codecResult[SessionKeys.playUri],
    );
  }
}
