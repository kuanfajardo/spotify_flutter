import 'package:spotify/core/core.dart' show SpotifySessionManager, SpotifySession;

abstract class SessionManagerState {
  final SpotifySessionManager sessionManager;
  Exception exception;
  bool isRenewed;

  SpotifySession get session;
  bool get isInitialized;

  SessionManagerState._([this.sessionManager]);

  factory SessionManagerState.uninitialized() {
    return _UninitializedSessionManagerState._();
  }

  factory SessionManagerState.initial(SpotifySessionManager sessionManager) {
    return _InitializedSessionManagerState._(sessionManager);
  }

  SessionManagerState asSuccess(SpotifySession session) {
    this.isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }

  SessionManagerState asFailure(String errorMessage) {
    this.isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }

  SessionManagerState asRenewed() {
    this .isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }
}


class _UninitializedSessionManagerState extends SessionManagerState {
  _UninitializedSessionManagerState._() : super._();

  @override
  bool get isInitialized => false;

  @override
  SpotifySession get session => null;
}

class _InitializedSessionManagerState extends SessionManagerState {
  _InitializedSessionManagerState._(SpotifySessionManager sessionManager) :
        super._(sessionManager);

  @override
  SpotifySession get session => this.sessionManager.session;

  @override
  bool get isInitialized => true;

  @override
  SessionManagerState asSuccess(SpotifySession session) {
    return this
      ..exception = null
      ..sessionManager.session = session
      ..isRenewed = false;
  }

  @override
  SessionManagerState asFailure(String errorMessage) {
    return this
      ..exception = Exception(errorMessage)
      ..sessionManager.session = null
      ..isRenewed = false;
  }

  @override
  SessionManagerState asRenewed() {
    return this..isRenewed = true;
  }
}