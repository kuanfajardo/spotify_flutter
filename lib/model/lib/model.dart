import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/model/lib/keys.dart' as ModelKeys;

class SpotifyContentItem implements Codecable {
  final String title;
  final String subtitle;
  final String identifier;
  final String uri;
  final bool isAvailableOffline;
  final bool isPlayable;
  final bool isContainer;

  SpotifyContentItem({this.title, this.subtitle, this.identifier, this.uri,
    this.isAvailableOffline, this.isPlayable, this.isContainer});

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.title: this.title,
      ModelKeys.subtitle: this.subtitle,
      ModelKeys.identifier: this.identifier,
      ModelKeys.uri: this.uri,
      ModelKeys.isAvailableOffline: this.isAvailableOffline,
      ModelKeys.isPlayable: this.isPlayable,
      ModelKeys.isContainer: this.isContainer,
    };
  }

  static SpotifyContentItem decode(Map<String, dynamic> codecResult) {
    return SpotifyContentItem(
      title: codecResult[ModelKeys.title],
      subtitle: codecResult[ModelKeys.subtitle],
      identifier: codecResult[ModelKeys.identifier],
      uri: codecResult[ModelKeys.uri],
      isAvailableOffline: codecResult[ModelKeys.isAvailableOffline],
      isPlayable: codecResult[ModelKeys.isPlayable],
      isContainer: codecResult[ModelKeys.isContainer],
    );
  }
}

class SpotifyArtist implements Codecable {
  final String name;
  final String uri;

  SpotifyArtist({this.name, this.uri});

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyArtist decode(Map<String, dynamic> codecResult) {
    return SpotifyArtist(
      name: codecResult[ModelKeys.name],
      uri: codecResult[ModelKeys.uri],
    );
  }
}

class SpotifyAlbum implements Codecable {
  final String name;
  final String uri;

  SpotifyAlbum({this.name, this.uri});

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyAlbum decode(Map<String, dynamic> codecResult) {
    return SpotifyAlbum(
      name: codecResult[ModelKeys.name],
      uri: codecResult[ModelKeys.uri],
    );
  }
}

class SpotifyTrack implements Codecable {
  final String name;
  final String uri;
  final int duration;
  final SpotifyArtist artist;
  final SpotifyAlbum album;
  final bool isSaved;
  final bool isEpisode;
  final bool isPodcast;

  SpotifyTrack({this.name, this.uri, this.duration, this.artist, this.album,
    this.isSaved, this.isEpisode, this.isPodcast});

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
      ModelKeys.duration: this.duration,
      ModelKeys.artist: this.artist.encode(),
      ModelKeys.album: this.album.encode(),
      ModelKeys.isSaved: this.isSaved,
      ModelKeys.isEpisode: this.isEpisode,
      ModelKeys.isPodcast: this.isPodcast,
    };
  }

  static SpotifyTrack decode(Map<String, dynamic> codecResult) {
    Map<String, dynamic> rawArtist = codecResult[ModelKeys.artist];
    Map<String, dynamic> rawAlbum = codecResult[ModelKeys.album];

    return SpotifyTrack(
      name: codecResult[ModelKeys.name],
      uri: codecResult[ModelKeys.uri],
      duration: codecResult[ModelKeys.duration],
      artist: Decoder.instance.decode<SpotifyArtist>(rawArtist),
      album: Decoder.instance.decode<SpotifyAlbum>(rawAlbum),
      isSaved: codecResult[ModelKeys.isSaved],
      isEpisode: codecResult[ModelKeys.isEpisode],
      isPodcast: codecResult[ModelKeys.isPodcast],
    );
  }
}