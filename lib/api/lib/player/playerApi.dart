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
class SpotifyPlaybackOptions implements Codec {
  final bool isShuffling;
  final SpotifyPlaybackOptionsRepeatMode repeatMode;

  SpotifyPlaybackOptions._from(Map<String, dynamic> codecResult) :
        isShuffling = codecResult[PlayerKeys.isShuffling],
        repeatMode = SpotifyPlaybackOptionsRepeatMode
            .values[codecResult[PlayerKeys.repeatMode]];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isShuffling: this.isShuffling,
      PlayerKeys.repeatMode: this.repeatMode,
    };
  }

  static SpotifyPlaybackOptions from(Map<String, dynamic> codecResult) {
    return SpotifyPlaybackOptions._from(codecResult);
  }
}

// SpotifyPlayerState
class SpotifyPlayerState implements Codec  {
  final SpotifyTrack track;
  final int playbackPosition;
  final double playbackSpeed;
  final bool isPaused;
  final SpotifyPlaybackRestrictions playbackRestrictions;
  final SpotifyPlaybackOptions playbackOptions;
  final String contextTitle;
  final String contextUri;

  SpotifyPlayerState._from(Map<String, dynamic> codecResult) :
        track = SpotifyTrack.from(codecResult[PlayerKeys.track]),
        playbackPosition = codecResult[PlayerKeys.playbackPosition],
        playbackSpeed = codecResult[PlayerKeys.playbackSpeed],
        isPaused = codecResult[PlayerKeys.isPaused],
        playbackRestrictions = SpotifyPlaybackRestrictions.from(codecResult[PlayerKeys.playbackRestrictions]),
        playbackOptions = SpotifyPlaybackOptions.from(codecResult[PlayerKeys.playbackOptions]),
        contextTitle = codecResult[PlayerKeys.contextTitle],
        contextUri = codecResult[PlayerKeys.contextUri];

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

  static SpotifyPlayerState from(Map<String, dynamic> codecResult) {
    return SpotifyPlayerState._from(codecResult);
  }
}

// SpotifyCrossfadeState
class SpotifyCrossfadeState implements Codec {
  final bool isEnabled;
  final int duration;

  SpotifyCrossfadeState._from(Map<String, dynamic> codecResult) :
        isEnabled = codecResult[PlayerKeys.isEnabled],
        duration = codecResult[PlayerKeys.duration];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isEnabled: this.isEnabled,
      PlayerKeys.duration: this.duration,
    };
  }

  static SpotifyCrossfadeState from(Map<String, dynamic> codecResult) {
    return SpotifyCrossfadeState._from(codecResult);
  }
}

// SpotifyPodcastPlaybackSpeed
class SpotifyPodcastPlaybackSpeed implements Codec  {
  final double value;

  SpotifyPodcastPlaybackSpeed._from(Map<String, dynamic> codecResult) :
      value = codecResult[PlayerKeys.value];

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.value: this.value
    };
  }

  static SpotifyPodcastPlaybackSpeed from(Map<String, dynamic> codecResult) {
    return SpotifyPodcastPlaybackSpeed._from(codecResult);
  }
}

// SpotifyPlaybackRestrictions
class SpotifyPlaybackRestrictions implements Codec {
  final bool canSkipNext;
  final bool canSkipPrevious;
  final bool canRepeatTrack;
  final bool canRepeatContext;
  final bool canToggleShuffle;
  final bool canSeek;

  SpotifyPlaybackRestrictions._from(Map<String, dynamic> codecResult) :
        canSkipNext = codecResult[PlayerKeys.canSkipNext],
        canSkipPrevious = codecResult[PlayerKeys.canSkipPrevious],
        canRepeatTrack = codecResult[PlayerKeys.canRepeatTrack],
        canRepeatContext = codecResult[PlayerKeys.canRepeatContext],
        canToggleShuffle = codecResult[PlayerKeys.canToggleShuffle],
        canSeek = codecResult[PlayerKeys.canSeek];

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

  static SpotifyPlaybackRestrictions from(Map<String, dynamic> codecResult) {
    return SpotifyPlaybackRestrictions._from(codecResult);
  }
}
