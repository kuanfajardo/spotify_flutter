abstract class SpotifyAlbum {
  String get name;
  String get uri;
}

abstract class SpotifyArtist {
  String get name;
  String get uri;
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
