import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/api/lib/user/methods.dart' as UserMethods;
import 'package:spotify/api/lib/user/keys.dart' as UserKeys;

// Caller
class SpotifyUserAPI {
  SpotifyUserAPIDelegate delegate;

  Future<SpotifyUserCapabilities> fetchCapabilities() {
    return invokeMethod<SpotifyUserCapabilities>(UserMethods.fetchCapabilities);
  }

  Future<bool> subscribeToCapabilityChanges() {
    return invokeMethod<bool>(UserMethods.subscribeToCapabilityChanges);
  }

  Future<bool> unsubscribeToCapabilityChanges() {
    return invokeMethod<bool>(UserMethods.unsubscribeToCapabilityChanges);
  }

  Future<SpotifyLibraryState> fetchLibraryStateForUri(Uri uri) {
    return invokeMethod<SpotifyLibraryState>(UserMethods
        .fetchLibraryStateForUri, uri.toString());
  }

  Future<bool> addUriToLibrary(Uri uri) { // tracks and albums only
    return invokeMethod<bool>(UserMethods.addUriToLibrary, uri.toString());
  }

  Future<bool> removeUriFromLibrary(Uri uri) { // tracks and albums
    return invokeMethod(UserMethods.removeUriFromLibrary, uri.toString());
  }
}

abstract class SpotifyUserAPIDelegate {
  void userAPIDidReceiveCapabilities(SpotifyUserCapabilities capabilities,
      [SpotifyUserAPI userAPI]);
}

class SpotifyLibraryState implements Codecable {
  final Uri uri;
  final bool isAdded;
  final bool canAdd;

  SpotifyLibraryState({this.uri, this.isAdded, this.canAdd});

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.uri: this.uri,
      UserKeys.isAdded: this.isAdded,
      UserKeys.canAdd: this.canAdd,
    };
  }

  static SpotifyLibraryState decode(Map<String, dynamic> codecResult) {
    String uriString = codecResult[UserKeys.uri];
    return SpotifyLibraryState(
      uri: Uri.dataFromString(uriString),
      isAdded: codecResult[UserKeys.isAdded],
      canAdd: codecResult[UserKeys.canAdd],
    );
  }
}

class SpotifyUserCapabilities implements Codecable {
  final bool canPlayOnDemand;

  SpotifyUserCapabilities(this.canPlayOnDemand);

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.canPlayOnDemand: this.canPlayOnDemand,
    };
  }

  static SpotifyUserCapabilities decode(Map<String, dynamic> codecResult) {
    return SpotifyUserCapabilities(codecResult[UserKeys.canPlayOnDemand]);
  }
}
