library app_remote_bloc;

import 'package:spotify/bloc/lib/app_remote/app_remote_event.dart';
import 'package:spotify/bloc/lib/app_remote/app_remote_state.dart';

import 'package:spotify/core/core.dart' show SpotifyAppRemote;

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

export 'package:spotify/bloc/lib/app_remote/app_remote_event.dart';
export 'package:spotify/bloc/lib/app_remote/app_remote_state.dart';

class AppRemoteBloc extends Bloc<AppRemoteEvent, AppRemoteState> {
  AppRemoteBloc() {
    const EventChannel _appRemoterDelegateChannel = EventChannel
      ('appRemoteDelegate');
    _appRemoterDelegateChannel.receiveBroadcastStream().map(this._convert)
        .listen(this.onEvent, onError: this.onError);
  }

  AppRemoteEvent _convert(dynamic event) {
    if (!this.currentState.isInitialized) {
      return null;
    }

    Map<String, dynamic> _event = event;
    String type = _event['eventType'];
    dynamic args = _event['args'];

    switch (type) {
      case 'didConnect':
        return ConnectionSuccessEvent();
      case 'didFailToConnect':
        String errorMessage = args as String;
        return ConnectionFailureEvent(errorMessage);
      case 'didDisconnect':
        String errorMessage = args as String;
        return DisconnectEvent(errorMessage);
      default:
        return null;
    }
  }

  @override
  AppRemoteState get initialState => AppRemoteState.uninitialized();

  @override
  Stream<AppRemoteState> mapEventToState(AppRemoteEvent event) async* {
    if (event is AppRemoteInitEvent) {
      yield AppRemoteState.initial(event.appRemote);
    }

    if (event is ConnectionSuccessEvent) {
      yield this.currentState.asConnected();
    }

    if (event is ConnectionFailureEvent) {
      yield this.currentState.asConnectionFailure(event.errorMessage);
    }

    if (event is DisconnectEvent) {
      yield this.currentState.asDisconnected(event.errorMessage);
    }
  }

  // Events
  void onInit(SpotifyAppRemote appRemote) {
    dispatch(AppRemoteInitEvent(appRemote));
  }

  void onConnectionSuccess() {
    dispatch(ConnectionSuccessEvent());
  }

  void onConnectionFailure(String errorMessage) {
    dispatch(ConnectionFailureEvent(errorMessage));
  }

  void onDisconnect(String errorMessage) {
    dispatch(ConnectionFailureEvent(errorMessage));
  }
}
