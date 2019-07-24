import 'package:spotify/core/core.dart' show SpotifySessionManager, SpotifySession;

abstract class SessionManagerEvent {}

class ManagerInitEvent extends SessionManagerEvent {
  SpotifySessionManager sessionManager;
  ManagerInitEvent(this.sessionManager);
}

class SessionSuccessEvent extends SessionManagerEvent {
  SpotifySession session;
  SessionSuccessEvent(this.session);
}

class SessionFailureEvent extends SessionManagerEvent {
  String errorMessage;
  SessionFailureEvent(this.errorMessage);
}

class SessionRenewEvent extends SessionManagerEvent {}