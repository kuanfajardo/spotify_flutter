import 'package:spotify/bloc/lib/session_manager/session_manager_state.dart';
import 'package:spotify/bloc/lib/session_manager/session_manager_event.dart';

import 'package:spotify/core/core.dart' show SpotifySessionManager, SpotifySession;

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

export 'package:spotify/bloc/lib/session_manager/session_manager_state.dart';
export 'package:spotify/bloc/lib/session_manager/session_manager_event.dart';

class SessionManagerBloc extends Bloc<SessionManagerEvent, SessionManagerState> {
  SessionManagerBloc() {
    const EventChannel _sessionManagerDelegateChannel = EventChannel
      ('sessionManagerDelegate');
    _sessionManagerDelegateChannel
        .receiveBroadcastStream()
        .map(this._convert)
        .listen(this.onEvent, onError: this.onError);
  }

  SessionManagerEvent _convert(dynamic event) {
    if (!this.currentState.isInitialized) {
      return null;
    }

    Map<String, dynamic> _event = event;
    String type = _event['type'];
    dynamic args = _event['args'];

    switch (type) {
      case 'didInitiate':
        SpotifySession session = SpotifySession.from(args as Map<String,
            dynamic>);
        return SessionSuccessEvent(session);
      case 'didFail':
        String errorMessage = args as String;
        return SessionFailureEvent(errorMessage);
      case 'didRenew':
        return SessionRenewEvent();
      default:
        return null;
    }
  }

  // Bloc Methods
  @override
  SessionManagerState get initialState => SessionManagerState.uninitialized();

  @override
  Stream<SessionManagerState> mapEventToState(SessionManagerEvent event)
  async* {
    if (event is ManagerInitEvent) {
      yield SessionManagerState.initial(event.sessionManager);
    }

    if (event is SessionSuccessEvent) {
      yield this.currentState.asSuccess(event.session);
    }

    if (event is SessionFailureEvent) {
      yield this.currentState.asFailure(event.errorMessage);
    }

    if (event is SessionRenewEvent) {
      yield this.currentState.asRenewed();
    }
  }

  // Events
  void onInit(SpotifySessionManager sessionManager) {
    dispatch(ManagerInitEvent(sessionManager));
  }

  void onSuccess(SpotifySession session) {
    dispatch(SessionSuccessEvent(session));
  }

  void onFailure(String errorMessage) {
    dispatch(SessionFailureEvent(errorMessage));
  }

  void onRenew() {
    dispatch(SessionRenewEvent());
  }
}
