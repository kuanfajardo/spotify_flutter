library spotify;

import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/api/api.dart';
import 'package:spotify/core/core.dart';
import 'package:spotify/model/model.dart';
import 'package:spotify/utils/utils.dart';

export 'package:spotify/api/api.dart';
export 'package:spotify/bloc/bloc.dart';
export 'package:spotify/core/core.dart';
export 'package:spotify/model/model.dart';
export 'package:spotify/stream/stream.dart';

void setup() {
  // Model
  Decoder.instance.registerDecodable<SpotifyContentItem>(SpotifyContentItem.from);
  Decoder.instance.registerDecodable<SpotifyTrack>(SpotifyTrack.from);
  Decoder.instance.registerDecodable<SpotifyAlbum>(SpotifyAlbum.from);
  Decoder.instance.registerDecodable<SpotifyArtist>(SpotifyArtist.from);

  // Session
  Decoder.instance.registerDecodable<SpotifySession>(SpotifySession.from);
  Decoder.instance.registerDecodable<SpotifyConfiguration>(SpotifyConfiguration.from);
  Decoder.instance.registerDecodable<SpotifyScope>(SpotifyScope.from);

  // AppRemote
  Decoder.instance.registerDecodable<SpotifyAppRemoteConnectionParams>
    (SpotifyAppRemoteConnectionParams.from);
  Decoder.instance.registerDecodable<SpotifyAuthorizationParameters>
    (SpotifyAuthorizationParameters.from);

  // ContentApi

  // ImageApi
  Decoder.instance.registerDecodable<SpotifyImageRepresentable>
    (SpotifyImageRepresentable.from);

  // PlayerApi
  Decoder.instance.registerDecodable<SpotifyPlaybackOptions>(SpotifyPlaybackOptions
      .from);
  Decoder.instance.registerDecodable<SpotifyCrossfadeState>
    (SpotifyCrossfadeState.from);
  Decoder.instance.registerDecodable<SpotifyPodcastPlaybackSpeed>
    (SpotifyPodcastPlaybackSpeed.from);
  Decoder.instance.registerDecodable<SpotifyPlayerState>
    (SpotifyPlayerState.from);
  Decoder.instance.registerDecodable<SpotifyPlaybackRestrictions>
    (SpotifyPlaybackRestrictions.from);

  // UserApi
  Decoder.instance.registerDecodable<SpotifyLibraryState>
    (SpotifyLibraryState.from);
  Decoder.instance.registerDecodable<SpotifyUserCapabilities>
    (SpotifyUserCapabilities.from);

  // Utils
  Decoder.instance.registerDecodable<CodecableSize>
    (CodecableSize.from);
  Decoder.instance.registerDecodable<DecodableImage>
    (DecodableImage.from);
}
