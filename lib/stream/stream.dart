import 'package:flutter/services.dart';
import 'package:spotify/api/api.dart' show SpotifyPlayerState, SpotifyUserCapabilities;

EventChannel _playerStateEventChannel = EventChannel('playerState');
Stream<SpotifyPlayerState> playerStateStream = _playerStateEventChannel
    .receiveBroadcastStream().map((dynamic event) {
      return SpotifyPlayerState.from(event as Map<String, dynamic>);
    });

EventChannel _userCapabilitiesChannel = EventChannel('userCapabilities');
Stream<SpotifyUserCapabilities> userCapabilitiesStream =
    _userCapabilitiesChannel.receiveBroadcastStream().map((dynamic event) {
      return SpotifyUserCapabilities.from(event as Map<String, dynamic>);
    });

