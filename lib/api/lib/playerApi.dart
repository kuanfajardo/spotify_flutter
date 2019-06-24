import 'package:spotify/core/core.dart';

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

abstract class SpotifyPlaybackOptions {
  bool get isShuffling;
  SpotifyPlaybackOptionsRepeatMode get repeatMode;
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

enum SpotifyPlaybackOptionsRepeatMode { off, track, context, }

abstract class SpotifyCrossfadeState {
  bool get isEnabled;
  int get duration;
}

abstract class SpotifyPodcastPlaybackSpeed {
  double get value;
}

abstract class SpotifyPlaybackRestrictions {
  bool get canSkipNext;
  bool get canSkipPrevious;
  bool get canRepeatTrack;
  bool get canRepeatContext;
  bool get canToggleShuffle;
  bool get canSeek;
}
