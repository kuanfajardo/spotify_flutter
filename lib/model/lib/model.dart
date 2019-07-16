import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/model/lib/keys.dart' as ModelKeys;

class SpotifyContentItem implements Codec {
  final String title;
  final String subtitle;
  final String identifier;
  final String uri;
  final bool isAvailableOffline;
  final bool isPlayable;
  final bool isContainer;
//  final List<SpotifyContentItem> children; TODO
  final String imageIdentifier;

  SpotifyContentItem._from(Map<String, dynamic> codecResult) :
        title = codecResult[ModelKeys.title],
        subtitle = codecResult[ModelKeys.subtitle],
        identifier = codecResult[ModelKeys.identifier],
        uri = codecResult[ModelKeys.uri],
        isAvailableOffline = codecResult[ModelKeys.isAvailableOffline],
        isPlayable = codecResult[ModelKeys.isPlayable],
        isContainer = codecResult[ModelKeys.isContainer],
        imageIdentifier = codecResult[ModelKeys.imageIdentifier];
//        children = codecResult[ModelKeys.children], TODO

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
      ModelKeys.imageIdentifier: this.imageIdentifier,
    };
  }

  static SpotifyContentItem from(Map<String, dynamic> codecResult) {
    return SpotifyContentItem._from(codecResult);
  }
}

class SpotifyArtist implements Codec {
  final String name;
  final String uri;

  SpotifyArtist._from(Map<String, dynamic> codecResult) :
        name = codecResult[ModelKeys.name],
        uri = codecResult[ModelKeys.uri];

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyArtist from(Map<String, dynamic> codecResult) {
    return SpotifyArtist._from(codecResult);
  }
}

class SpotifyAlbum implements Codec {
  final String name;
  final String uri;

  SpotifyAlbum._from(Map<String, dynamic> codecResult) :
        name = codecResult[ModelKeys.name],
        uri = codecResult[ModelKeys.uri];

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyAlbum from(Map<String, dynamic> codecResult) {
    return SpotifyAlbum._from(codecResult);
  }
}

class SpotifyTrack implements Codec {
  final String name;
  final String uri;
  final int duration;
  final SpotifyArtist artist;
  final SpotifyAlbum album;
  final bool isSaved;
  final bool isEpisode;
  final bool isPodcast;

  SpotifyTrack._from(Map<String, dynamic> codecResult) :
        name = codecResult[ModelKeys.name],
        uri = codecResult[ModelKeys.uri],
        duration = codecResult[ModelKeys.duration],
        artist = SpotifyArtist.from(codecResult[ModelKeys.artist]),
        album = SpotifyAlbum.from(codecResult[ModelKeys.album]),
        isSaved = codecResult[ModelKeys.isSaved],
        isEpisode = codecResult[ModelKeys.isEpisode],
        isPodcast = codecResult[ModelKeys.isPodcast];

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

  static SpotifyTrack from(Map<String, dynamic> codecResult) {
    return SpotifyTrack._from(codecResult);
  }
}