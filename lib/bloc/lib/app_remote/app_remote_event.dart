import 'package:spotify/core/core.dart' show SpotifyAppRemote;

abstract class AppRemoteEvent {}

class AppRemoteInitEvent extends AppRemoteEvent {
  SpotifyAppRemote appRemote;
  AppRemoteInitEvent(this.appRemote);
}

class ConnectionSuccessEvent extends AppRemoteEvent {}

class ConnectionFailureEvent extends AppRemoteEvent {
  String errorMessage;
  ConnectionFailureEvent(this.errorMessage);
}

class DisconnectEvent extends AppRemoteEvent {
  String errorMessage;
  DisconnectEvent(this.errorMessage);
}
