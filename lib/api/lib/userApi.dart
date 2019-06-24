abstract class SpotifyUserAPI {
  SpotifyUserAPIDelegate delegate;
  Future<SpotifyUserCapabilities> fetchCapabilities();
  Future<bool> subscribeToCapabilityChanges();
  Future<bool> unsubscribeToCapabilityChanges();
  Future<SpotifyLibraryState> fetchLibraryStateForUri(String uri);
  Future<bool> addUriToLibrary(String uri); // tracks and albums only
  Future<bool> removeUriFromLibrary(String uri); // tracks and albums
}

abstract class SpotifyUserAPIDelegate {
  void userAPIDidReceiveCapabilities(SpotifyUserCapabilities capabilities,
      [SpotifyUserAPI userAPI]);
}

abstract class SpotifyLibraryState {
  String get uri;
  bool get isAdded;
  bool get canAdd;
}

abstract class SpotifyUserCapabilities {
  bool get canPlayOnDemand;
}
