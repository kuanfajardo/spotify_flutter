import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:meta/meta.dart';

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

  // TODO: get's?
  static Future<bool> checkIfSpotifyAppIsActive();
  static String version();
  static int spotifyItunesItemIdentifier();

  bool get isConnected;
  Spotify delegate;

  void connect();
  void disconnect();
  bool authorizeAndPlayUri(String uri);
  Map<String, String> authoriztionParametersFromURL(Uri url);

  SpotifyPlayerAPI get playerAPI;
  SpotifyImageAPI get imageAPI;
  SpotifyUserAPI get userAPI;
  SpotifyContentAPI get contentAPI;
}

const String kSpotifyAccessTokenKey = ""; // TODO
const String kSpotifyErrorDescriptionKey = ""; // TODO

enum SpotifyLogLevel { none, debug, info, error, }

enum SpotifyExceptionCode { unknown, authorizationFailed, renewSessionFailed,
  jsonFailed, }

enum SpotifyConnectionParamsImageFormat { any, jpeg, png, }

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

enum SpotifyContentType { default_, navigation, fitness, }

enum SpotifyPlaybackOptionsRepeatMode { off, track, context, }

class SpotifyConfiguration {
  final String clientId;
  final Uri redirectUrl;
  Uri tokenSwapUrl;
  Uri tokenRefreshUrl;
  String playURL;

  SpotifyConfiguration({this.clientId, this.redirectUrl});
}

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
// TODO: Uri's -> objects
// TODO: Future<bool> necessary bool?
// SpotifyDelegate
abstract class SpotifyPlayerAPI {
  SpotifyPlayerStateDelegate delegate;
  Future<bool> play(String entityIdentifier);
  Future<bool> playItem(SpotifyContentItem contentItem, {int startIndex});
  Future<bool> resume();
  Future<bool> pause();
  Future<bool> skipToNext();
  Future<bool> skipToPrevious();
  Future<bool> seekToPosition(int position);
  Future<bool> seekForward15Seconds();
  Future<bool> seekBackward15Seconds();
  Future<bool> setShuffle(bool shuffle);
  Future<bool> setRepeatMode(SpotifyPlaybackOptionsRepeatMode repeatMode);
  Future<SpotifyPlayerState> getPlayerState();
  Future<SpotifyPlayerState> subscribeToPlayerState();
  Future<bool> unsubscribeToPlayerState();
  Future<bool> enqueueTrackUri(String trackUri);
  Future<List<SpotifyPodcastPlaybackSpeed>> getAvailablePodcastPlaybackSpeeds;
  Future<SpotifyPodcastPlaybackSpeed> getCurrentPodcastPlaybackSpeed;
  Future<bool> setPodcastPlaybackSpeed(SpotifyPodcastPlaybackSpeed speed);
  Future<SpotifyCrossfadeState> getCrossfadeState();
}
abstract class SpotifyImageAPI {
  Future<Image> fetchImageForItem(SpotifyImageRepresentable imageItem, {Size
  size});
}
abstract class SpotifyUserAPI {
  SpotifyUserAPIDelegate delegate;
  Future<SpotifyUserCapabilities> fetchCapabilities();
  Future<bool> subscribeToCapabilityChanges();
  Future<bool> unsubscribeToCapabilityChanges();
  Future<SpotifyLibraryState> fetchLibraryStateForUri(String uri);
  Future<bool> addUriToLibrary(String uri); // tracks and albums only
  Future<bool> removeUriFromLibrary(String uri); // tracks and albums
}
abstract class SpotifyUserAPIDelegate {
  void userAPIDidReceiveCapabilities(SpotifyUserCapabilities capabilities,
      [SpotifyUserAPI userAPI]);
}
abstract class SpotifyDelegate {
  void spotifyDidEstablishConnection([Spotify spotify]);
  void spotifyDidFailConnectionAttemptWithException(Exception e, [Spotify
    spotify]);
  void spotifyDidDisconnectWithException(Exception e, [Spotify spotify]);
}
abstract class SpotifyContentAPI {
  Future fetchRootContentItemsForType(SpotifyContentType contentType);
  Future fetchChildrenOfContentItem(SpotifyContentItem contentItem);
  Future fetchRecommendedContentItemsForType(SpotifyContentType contentType,
      {bool flattenContainers});
}
class SpotifyException implements Exception {
  final SpotifyExceptionCode errorCode;
  final String message;

  SpotifyException(this.errorCode, {this.message});

  @override
  String toString() {
    return 'SpotifyException (${this.errorCode}): ${this.message}';
  }
}
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
abstract class SpotifyAlbum {
  String get name;
  String get uri;
}
abstract class SpotifyArtist {
  String get name;
  String get uri;
}
abstract class SpotifyContentItem {
  String get title;
  String get subtitle;
  String get identifier;
  String get uri;
  bool get isAvailableOffline;
  bool get isPlayable;
  bool get isContainer;
  // children
}
abstract class SpotifyCrossfadeState {
  bool get isEnabled;
  int get duration;
}
abstract class SpotifyImageRepresentable {
  String get imageIdentifier;
}
abstract class SpotifyLibraryState {
  String get uri;
  bool get isAdded;
  bool get canAdd;
}
abstract class SpotifyPlaybackOptions {
  bool get isShuffling;
  SpotifyPlaybackOptionsRepeatMode get repeatMode;
}
abstract class SpotifyPlaybackRestrictions {
  bool get canSkipNext;
  bool get canSkipPrevious;
  bool get canRepeatTrack;
  bool get canRepeatContext;
  bool get canToggleShuffle;
  bool get canSeek;
}
abstract class SpotifyPlayerState {
  SpotifyTrack get track;
  int get playbackPosition;
  double get playbackSpeed;
  bool get isPaused;
  SpotifyPlaybackRestrictions get playbackRestrictions;
  SpotifyPlaybackOptions get playbackOptions;
  String get contextTitle;
  String get contextUri;
}
abstract class SpotifyPlayerStateDelegate {
  void playerStateDidChange(SpotifyPlayerState playerState);
}
abstract class SpotifyPodcastPlaybackSpeed {
  double get value;
}
abstract class SpotifyTrack {
  String get name;
  String get uri;
  int get duration;
  SpotifyArtist get artist;
  SpotifyAlbum get album;
  bool get isSaved;
  bool get isEpisode;
  bool get isPodcast;
}
abstract class SpotifyUserCapabilities {
  bool get canPlayOnDemand;
}
