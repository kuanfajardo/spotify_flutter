import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/model/model.dart';

import 'package:spotify/api/lib/player/methods.dart' as PlayerMethods;
import 'package:spotify/api/lib/player/keys.dart' as PlayerKeys;

enum SpotifyPlaybackOptionsRepeatMode { off, track, context, }

// Caller
class SpotifyPlayerAPI {
  Future<bool> play(String entityIdentifier) {
    return invokeMethod<bool>(PlayerMethods.play, entityIdentifier);
  }

  Future<bool> playItem(SpotifyContentItem contentItem, {int startIndex}) {
    Map args = {
      PlayerKeys.contentItem: contentItem.encode(),
      PlayerKeys.startIndex: startIndex
    };
    return invokeMethod<bool>(PlayerMethods.playItem, args);
  }

  Future<bool> resume() {
    return invokeMethod<bool>(PlayerMethods.resume);
  }

  Future<bool> pause() {
    return invokeMethod<bool>(PlayerMethods.pause);
  }

  Future<bool> skipToNext() {
    return invokeMethod<bool>(PlayerMethods.skipToNext);
  }

  Future<bool> skipToPrevious() {
    return invokeMethod<bool>(PlayerMethods.skipToPrevious);
  }

  Future<bool> seekToPosition(int position) {
    return invokeMethod<bool>(PlayerMethods.seekToPosition, position);
  }

  Future<bool> seekForward15Seconds() {
    return invokeMethod<bool>(PlayerMethods.seekForward15Seconds);
  }

  Future<bool> seekBackward15Seconds() {
    return invokeMethod<bool>(PlayerMethods.seekBackward15Seconds);
  }

  Future<bool> setShuffle(bool shuffle) {
    return invokeMethod<bool>(PlayerMethods.setShuffle, shuffle);
  }

  Future<bool> setRepeatMode(SpotifyPlaybackOptionsRepeatMode repeatMode) {
    return invokeMethod<bool>(PlayerMethods.setRepeatMode, repeatMode); // TODO: maybe
    // .index
  }

  Future<SpotifyPlayerState> getPlayerState() {
    return invokeMethod<SpotifyPlayerState>(PlayerMethods.getPlayerState);
  }

  Future<SpotifyPlayerState> subscribeToPlayerState() {
    return invokeMethod<SpotifyPlayerState>(PlayerMethods.subscribeToPlayerState);
  }

  Future<bool> unsubscribeToPlayerState() {
    return invokeMethod<bool>(PlayerMethods.unsubscribeToPlayerState);
  }

  Future<bool> enqueueTrackUri(String trackUri) {
    return invokeMethod<bool>(PlayerMethods.enqueueTrackUri, trackUri);
  }

  Future<List<SpotifyPodcastPlaybackSpeed>> getAvailablePodcastPlaybackSpeeds() {
    return invokeListMethod<SpotifyPodcastPlaybackSpeed>(PlayerMethods.getAvailablePodcastPlaybackSpeeds);
  }

  Future<SpotifyPodcastPlaybackSpeed> getCurrentPodcastPlaybackSpeed() {
    return invokeMethod<SpotifyPodcastPlaybackSpeed>(PlayerMethods.getCurrentPodcastPlaybackSpeed);
  }

  Future<bool> setPodcastPlaybackSpeed(SpotifyPodcastPlaybackSpeed speed) {
    return invokeMethod<bool>(PlayerMethods.setPodcastPlaybackSpeed, speed);
  }

  Future<SpotifyCrossfadeState> getCrossfadeState() {
    return invokeMethod<SpotifyCrossfadeState>(PlayerMethods.getCrossfadeState);
  }
}

// SpotifyPlaybackOptions
class SpotifyPlaybackOptions implements FlutterChannelCodable {
  final bool isShuffling;
  final SpotifyPlaybackOptionsRepeatMode repeatMode;

  SpotifyPlaybackOptions._from(Map<String, dynamic> channelObject) :
        isShuffling = channelObject[PlayerKeys.isShuffling],
        repeatMode = SpotifyPlaybackOptionsRepeatMode
            .values[channelObject[PlayerKeys.repeatMode]];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isShuffling: this.isShuffling,
      PlayerKeys.repeatMode: this.repeatMode,
    };
  }

  static SpotifyPlaybackOptions from(Map<String, dynamic> channelObject) {
    return SpotifyPlaybackOptions._from(channelObject);
  }
}

// SpotifyPlayerState
class SpotifyPlayerState implements FlutterChannelCodable  {
  final SpotifyTrack track;
  final int playbackPosition;
  final double playbackSpeed;
  final bool isPaused;
  final SpotifyPlaybackRestrictions playbackRestrictions;
  final SpotifyPlaybackOptions playbackOptions;
  final String contextTitle;
  final String contextUri;

  SpotifyPlayerState._from(Map<String, dynamic> channelObject) :
        track = SpotifyTrack.from(channelObject[PlayerKeys.track]),
        playbackPosition = channelObject[PlayerKeys.playbackPosition],
        playbackSpeed = channelObject[PlayerKeys.playbackSpeed],
        isPaused = channelObject[PlayerKeys.isPaused],
        playbackRestrictions = SpotifyPlaybackRestrictions.from(channelObject[PlayerKeys.playbackRestrictions]),
        playbackOptions = SpotifyPlaybackOptions.from(channelObject[PlayerKeys.playbackOptions]),
        contextTitle = channelObject[PlayerKeys.contextTitle],
        contextUri = channelObject[PlayerKeys.contextUri];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.track: this.track.encode(),
      PlayerKeys.playbackPosition: this.playbackPosition,
      PlayerKeys.playbackSpeed: this.playbackSpeed,
      PlayerKeys.isPaused: this.isPaused,
      PlayerKeys.playbackRestrictions: this.playbackRestrictions.encode(),
      PlayerKeys.playbackOptions: this.playbackOptions.encode(),
      PlayerKeys.contextTitle: this.contextTitle,
      PlayerKeys.contextUri: this.contextUri,
    };
  }

  static SpotifyPlayerState from(Map<String, dynamic> channelObject) {
    return SpotifyPlayerState._from(channelObject);
  }
}

// SpotifyCrossfadeState
class SpotifyCrossfadeState implements FlutterChannelCodable {
  final bool isEnabled;
  final int duration;

  SpotifyCrossfadeState._from(Map<String, dynamic> channelObject) :
        isEnabled = channelObject[PlayerKeys.isEnabled],
        duration = channelObject[PlayerKeys.duration];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isEnabled: this.isEnabled,
      PlayerKeys.duration: this.duration,
    };
  }

  static SpotifyCrossfadeState from(Map<String, dynamic> channelObject) {
    return SpotifyCrossfadeState._from(channelObject);
  }
}

// SpotifyPodcastPlaybackSpeed
class SpotifyPodcastPlaybackSpeed implements FlutterChannelCodable  {
  final double value;

  SpotifyPodcastPlaybackSpeed._from(Map<String, dynamic> channelObject) :
      value = channelObject[PlayerKeys.value];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.value: this.value
    };
  }

  static SpotifyPodcastPlaybackSpeed from(Map<String, dynamic> channelObject) {
    return SpotifyPodcastPlaybackSpeed._from(channelObject);
  }
}

// SpotifyPlaybackRestrictions
class SpotifyPlaybackRestrictions implements FlutterChannelCodable {
  final bool canSkipNext;
  final bool canSkipPrevious;
  final bool canRepeatTrack;
  final bool canRepeatContext;
  final bool canToggleShuffle;
  final bool canSeek;

  SpotifyPlaybackRestrictions._from(Map<String, dynamic> channelObject) :
        canSkipNext = channelObject[PlayerKeys.canSkipNext],
        canSkipPrevious = channelObject[PlayerKeys.canSkipPrevious],
        canRepeatTrack = channelObject[PlayerKeys.canRepeatTrack],
        canRepeatContext = channelObject[PlayerKeys.canRepeatContext],
        canToggleShuffle = channelObject[PlayerKeys.canToggleShuffle],
        canSeek = channelObject[PlayerKeys.canSeek];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.canSkipNext: this.canSkipNext,
      PlayerKeys.canSkipPrevious: this.canSkipPrevious,
      PlayerKeys.canRepeatTrack: this.canRepeatTrack,
      PlayerKeys.canRepeatContext: this.canRepeatContext,
      PlayerKeys.canToggleShuffle: this.canToggleShuffle,
      PlayerKeys.canSeek: this.canSkipPrevious,
    };
  }

  static SpotifyPlaybackRestrictions from(Map<String, dynamic> channelObject) {
    return SpotifyPlaybackRestrictions._from(channelObject);
  }
}
