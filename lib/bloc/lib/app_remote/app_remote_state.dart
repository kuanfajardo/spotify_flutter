import 'package:spotify/core/core.dart' show SpotifyAppRemote;

abstract class AppRemoteState {
  final SpotifyAppRemote appRemote;
  bool isConnected = false;
  Exception exception;

  bool get isInitialized;

  AppRemoteState._([this.appRemote]);

  factory AppRemoteState.uninitialized() {
    return _UninitializedAppRemoteState();
  }

  factory AppRemoteState.initial(SpotifyAppRemote appRemote) {
    return _InitializedAppRemoteState(appRemote);
  }

  AppRemoteState asConnected() {
    this.isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }

  AppRemoteState asConnectionFailure(String errorMessage) {
    this.isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }

  AppRemoteState asDisconnected(String errorMessage) {
    this.isInitialized
        ? throw AssertionError('Invalid state.')
        : throw UnimplementedError();
  }
}

class _UninitializedAppRemoteState extends AppRemoteState {
  _UninitializedAppRemoteState() : super._();

  @override
  bool get isInitialized => false;
}

class _InitializedAppRemoteState extends AppRemoteState {
  _InitializedAppRemoteState(SpotifyAppRemote appRemote) : super._(appRemote);

  @override
  bool get isInitialized => true;

  @override
  AppRemoteState asConnected() {
    return this..isConnected = true;
  }

  @override
  AppRemoteState asConnectionFailure(String errorMessage) {
    return this..isConnected = false..exception = Exception(errorMessage);
  }

  @override
  AppRemoteState asDisconnected(String errorMessage) {
    return this..isConnected = false..exception = Exception(errorMessage);
  }
}