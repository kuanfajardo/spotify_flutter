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

abstract class SpotifySession {
  String get accessToken;
  String get refreshToken;
  DateTime get expirationDate;
  SpotifyScope get scope;
  bool get isExpired;
}

abstract class SpotifySessionManager {
  final SpotifyConfiguration configuration;

  SpotifySession session;
  SpotifySessionManagerDelegate delegate;
  bool alwaysShowAuthorizationDialog;

  SpotifySessionManager(this.configuration);

  bool isSpotifyAppInstalled();
  void initiateSessionWithScope(SpotifyScope scope,
      {SpotifyAuthorizationOptions options});
  void renewSession();
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

class SpotifyConfiguration {
  final String clientId;
  final Uri redirectUrl;
  Uri tokenSwapUrl;
  Uri tokenRefreshUrl;
  String playURL;

  SpotifyConfiguration({this.clientId, this.redirectUrl});
}
