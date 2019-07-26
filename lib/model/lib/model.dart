import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/model/lib/keys.dart' as ModelKeys;

class SpotifyContentItem implements FlutterChannelCodable {
  final String title;
  final String subtitle;
  final String identifier;
  final String uri;
  final bool isAvailableOffline;
  final bool isPlayable;
  final bool isContainer;
//  final List<SpotifyContentItem> children; TODO
  final String imageIdentifier;

  SpotifyContentItem._from(Map<String, dynamic> channelObject) :
        title = channelObject[ModelKeys.title],
        subtitle = channelObject[ModelKeys.subtitle],
        identifier = channelObject[ModelKeys.identifier],
        uri = channelObject[ModelKeys.uri],
        isAvailableOffline = channelObject[ModelKeys.isAvailableOffline],
        isPlayable = channelObject[ModelKeys.isPlayable],
        isContainer = channelObject[ModelKeys.isContainer],
        imageIdentifier = channelObject[ModelKeys.imageIdentifier];
//        children = channelObject[ModelKeys.children], TODO

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

  static SpotifyContentItem from(Map<String, dynamic> channelObject) {
    return SpotifyContentItem._from(channelObject);
  }
}

class SpotifyArtist implements FlutterChannelCodable {
  final String name;
  final String uri;

  SpotifyArtist._from(Map<String, dynamic> channelObject) :
        name = channelObject[ModelKeys.name],
        uri = channelObject[ModelKeys.uri];

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyArtist from(Map<String, dynamic> channelObject) {
    return SpotifyArtist._from(channelObject);
  }
}

class SpotifyAlbum implements FlutterChannelCodable {
  final String name;
  final String uri;

  SpotifyAlbum._from(Map<String, dynamic> channelObject) :
        name = channelObject[ModelKeys.name],
        uri = channelObject[ModelKeys.uri];

  @override
  Map<String, dynamic> encode() {
    return {
      ModelKeys.name: this.name,
      ModelKeys.uri: this.uri,
    };
  }

  static SpotifyAlbum from(Map<String, dynamic> channelObject) {
    return SpotifyAlbum._from(channelObject);
  }
}

class SpotifyTrack implements FlutterChannelCodable {
  final String name;
  final String uri;
  final int duration;
  final SpotifyArtist artist;
  final SpotifyAlbum album;
  final bool isSaved;
  final bool isEpisode;
  final bool isPodcast;

  SpotifyTrack._from(Map<String, dynamic> channelObject) :
        name = channelObject[ModelKeys.name],
        uri = channelObject[ModelKeys.uri],
        duration = channelObject[ModelKeys.duration],
        artist = SpotifyArtist.from(channelObject[ModelKeys.artist]),
        album = SpotifyAlbum.from(channelObject[ModelKeys.album]),
        isSaved = channelObject[ModelKeys.isSaved],
        isEpisode = channelObject[ModelKeys.isEpisode],
        isPodcast = channelObject[ModelKeys.isPodcast];

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

  static SpotifyTrack from(Map<String, dynamic> channelObject) {
    return SpotifyTrack._from(channelObject);
  }
}