import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ui';

class Spotify {
  static const MethodChannel _channel =
      const MethodChannel('spotify');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

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
  // delegate
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
  // delegate
  Future<SpotifyUserCapabilities> fetchCapabilities();
  Future<bool> subscribeToCapabilityChanges();
  Future<bool> unsubscribeToCapabilityChanges();
  Future<SpotifyLibraryState> fetchLibraryStateForUri(String uri);
  Future<bool> addUriToLibrary(String uri); // tracks and albums only
  Future<bool> removeUriFromLibrary(String uri); // tracks and albums
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
class SpotifySession {}
class SpotifySessionManager {}
// SpotifySessionManagerDelegate
class SpotifyAlbum {}
class SpotifyArtist {}
class SpotifyContentItem {}
class SpotifyCrossfadeState {}
class SpotifyImageRepresentable {}
class SpotifyLibraryState {}
class SpotifyPlaybackOptions {}
class SpotifyPlaybackRestrictions {}
class SpotifyPlayerState {}
// SpotifyPlayerStateDelegate
class SpotifyPodcastPlaybackSpeed {}
class SpotifyTrack {}
class SpotifyUserAPIDelegate {}
class SpotifyUserCapabilities {}
