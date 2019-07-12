import 'package:spotify/encoding/encoding.dart';
import 'package:spotify/model/model.dart';

import 'package:spotify/api/lib/player/methods.dart' as PlayerMethods;
import 'package:spotify/api/lib/player/keys.dart' as PlayerKeys;

enum SpotifyPlaybackOptionsRepeatMode { off, track, context, }

void setup() {
  Decoder.instance.registerCodecable<SpotifyPlayerState>(SpotifyPlayerState
      .decode);
  Decoder.instance.registerCodecable<SpotifyCrossfadeState>
    (SpotifyCrossfadeState.decode);
  Decoder.instance.registerCodecable<SpotifyPodcastPlaybackSpeed>
    (SpotifyPodcastPlaybackSpeed.decode);
}

// Caller
class SpotifyPlayerAPI {
  SpotifyPlayerStateDelegate delegate;

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
class SpotifyPlaybackOptions implements Codecable {
  final bool isShuffling;
  final SpotifyPlaybackOptionsRepeatMode repeatMode;

  SpotifyPlaybackOptions({this.isShuffling, this.repeatMode});

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isShuffling: this.isShuffling,
      PlayerKeys.repeatMode: this.repeatMode,
    };
  }

  static SpotifyPlaybackOptions decode(Map<String, dynamic> codecResult) {
    int repeatModeIndex = codecResult[PlayerKeys.repeatMode];
    return SpotifyPlaybackOptions(
      isShuffling: codecResult[PlayerKeys.isShuffling],
      repeatMode: SpotifyPlaybackOptionsRepeatMode.values[repeatModeIndex],
    );
  }
}

// SpotifyPlayerState
class SpotifyPlayerState extends Codecable  {
  final SpotifyTrack track;
  final int playbackPosition;
  final double playbackSpeed;
  final bool isPaused;
  final SpotifyPlaybackRestrictions playbackRestrictions;
  final SpotifyPlaybackOptions playbackOptions;
  final String contextTitle;
  final String contextUri;

  SpotifyPlayerState({this.track, this.playbackPosition, this.playbackSpeed,
      this.isPaused, this.playbackRestrictions, this.playbackOptions,
      this.contextTitle, this.contextUri});

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

  static SpotifyPlayerState decode(Map<String, dynamic> codecResult) {
    Map<String, dynamic> rawTrack = codecResult[PlayerKeys
        .track];
    Map<String, dynamic> rawPlaybackRestrictions = codecResult[PlayerKeys
        .playbackRestrictions];
    Map<String, dynamic> rawPlaybackOptions = codecResult[PlayerKeys
        .playbackOptions];

    return SpotifyPlayerState(
      track: Decoder.instance.decode<SpotifyTrack>(rawTrack),
      playbackPosition: codecResult[PlayerKeys.playbackPosition],
      playbackSpeed: codecResult[PlayerKeys.playbackSpeed],
      isPaused: codecResult[PlayerKeys.isPaused],
      playbackRestrictions: Decoder.instance
          .decode<SpotifyPlaybackRestrictions>(rawPlaybackRestrictions),
      playbackOptions: Decoder.instance.decode<SpotifyPlaybackOptions>
        (rawPlaybackOptions),
      contextTitle: codecResult[PlayerKeys.contextTitle],
      contextUri: codecResult[PlayerKeys.contextUri],
    );
  }
}

// SpotifyPlayerStateDelegate
abstract class SpotifyPlayerStateDelegate {
  void playerStateDidChange(SpotifyPlayerState playerState);
}

// SpotifyCrossfadeState
class SpotifyCrossfadeState implements Codecable {
  final bool isEnabled;
  final int duration;

  SpotifyCrossfadeState({this.isEnabled, this.duration});

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.isEnabled: this.isEnabled,
      PlayerKeys.duration: this.duration,
    };
  }

  static SpotifyCrossfadeState decode(Map<String, dynamic> codecResult) {
    return SpotifyCrossfadeState(
      isEnabled: codecResult[PlayerKeys.isEnabled],
      duration: codecResult[PlayerKeys.duration],
    );
  }
}

// SpotifyPodcastPlaybackSpeed
class SpotifyPodcastPlaybackSpeed implements Codecable  {
  final double value;

  SpotifyPodcastPlaybackSpeed(this.value);

  @override
  Map<String, dynamic> encode() {
    return {
      PlayerKeys.value: this.value
    };
  }

  static SpotifyPodcastPlaybackSpeed decode(Map<String, dynamic> codecResult) {
    return SpotifyPodcastPlaybackSpeed(codecResult[PlayerKeys.value]);
  }
}

// SpotifyPlaybackRestrictions
class SpotifyPlaybackRestrictions implements Codecable {
  final bool canSkipNext;
  final bool canSkipPrevious;
  final bool canRepeatTrack;
  final bool canRepeatContext;
  final bool canToggleShuffle;
  final bool canSeek;

  SpotifyPlaybackRestrictions({this.canSkipNext, this.canSkipPrevious,
      this.canRepeatTrack, this.canRepeatContext, this.canToggleShuffle,
      this.canSeek});

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

  static SpotifyPlaybackRestrictions decode(Map<String, dynamic> codecResult) {
    return SpotifyPlaybackRestrictions(
      canSkipNext: codecResult[PlayerKeys.canSkipNext],
      canSkipPrevious: codecResult[PlayerKeys.canSkipPrevious],
      canRepeatTrack: codecResult[PlayerKeys.canRepeatTrack],
      canRepeatContext: codecResult[PlayerKeys.canRepeatContext],
      canToggleShuffle: codecResult[PlayerKeys.canToggleShuffle],
      canSeek: codecResult[PlayerKeys.canSeek],
    );
  }
}
