library spotify;

import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/api/api.dart';
import 'package:spotify/core/core.dart';
import 'package:spotify/model/model.dart';
import 'package:spotify/utils/utils.dart';

export 'package:spotify/api/api.dart';
export 'package:spotify/core/core.dart';
export 'package:spotify/model/model.dart';

void setup() {
  // Model
  Decoder.instance.registerCodecable<SpotifyContentItem>(SpotifyContentItem.from);
  Decoder.instance.registerCodecable<SpotifyTrack>(SpotifyTrack.from);
  Decoder.instance.registerCodecable<SpotifyAlbum>(SpotifyAlbum.from);
  Decoder.instance.registerCodecable<SpotifyArtist>(SpotifyArtist.from);

  // Session
  Decoder.instance.registerCodecable<SpotifySession>(SpotifySession.from);
  Decoder.instance.registerCodecable<SpotifyConfiguration>(SpotifyConfiguration.from);
  Decoder.instance.registerCodecable<SpotifyScope>(SpotifyScope.from);

  // AppRemote
  Decoder.instance.registerCodecable<SpotifyAppRemoteConnectionParams>
    (SpotifyAppRemoteConnectionParams.from);
  Decoder.instance.registerCodecable<SpotifyAuthorizationParameters>
    (SpotifyAuthorizationParameters.from);

  // ContentApi

  // ImageApi
  Decoder.instance.registerCodecable<SpotifyImageRepresentable>
    (SpotifyImageRepresentable.from);

  // PlayerApi
  Decoder.instance.registerCodecable<SpotifyPlaybackOptions>(SpotifyPlaybackOptions
      .from);
  Decoder.instance.registerCodecable<SpotifyCrossfadeState>
    (SpotifyCrossfadeState.from);
  Decoder.instance.registerCodecable<SpotifyPodcastPlaybackSpeed>
    (SpotifyPodcastPlaybackSpeed.from);
  Decoder.instance.registerCodecable<SpotifyPlayerState>
    (SpotifyPlayerState.from);
  Decoder.instance.registerCodecable<SpotifyPlaybackRestrictions>
    (SpotifyPlaybackRestrictions.from);

  // UserApi
  Decoder.instance.registerCodecable<SpotifyLibraryState>
    (SpotifyLibraryState.from);
  Decoder.instance.registerCodecable<SpotifyUserCapabilities>
    (SpotifyUserCapabilities.from);

  // Utils
  Decoder.instance.registerCodecable<CodecableSize>
    (CodecableSize.from);
  Decoder.instance.registerCodecable<CodecableImage>
    (CodecableImage.from);
}
