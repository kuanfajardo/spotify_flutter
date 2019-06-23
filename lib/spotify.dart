import 'dart:async';

import 'package:flutter/services.dart';

class Spotify {
  static const MethodChannel _channel =
      const MethodChannel('spotify');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

enum SpotifyLogLevel { none, debug, info, error, }

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

class SpotifyConfiguration {}
class SpotifyConnectionParams {}
// SpotifyDelegate
class SpotifyPlayerAPI {}
class SpotifyImageAPI {}
class SpotifyUserAPI {}
class SpotifyContentAPI {}
class SpotifyError {}
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
