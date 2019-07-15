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

class SpotifyLibraryState implements Codec {
  final Uri uri;
  final bool isAdded;
  final bool canAdd;

  SpotifyLibraryState._from(Map<String, dynamic> codecResult) :
        uri = Uri.dataFromString(codecResult[UserKeys.uri]),
        isAdded = codecResult[UserKeys.isAdded],
        canAdd = codecResult[UserKeys.canAdd];

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.uri: this.uri,
      UserKeys.isAdded: this.isAdded,
      UserKeys.canAdd: this.canAdd,
    };
  }

  static SpotifyLibraryState from(Map<String, dynamic> codecResult) {
    return SpotifyLibraryState._from(codecResult);
  }
}

class SpotifyUserCapabilities implements Codec {
  final bool canPlayOnDemand;

  SpotifyUserCapabilities._from(Map<String, dynamic> codecResult) :
      canPlayOnDemand = codecResult[UserKeys.canPlayOnDemand];

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.canPlayOnDemand: this.canPlayOnDemand,
    };
  }

  static SpotifyUserCapabilities from(Map<String, dynamic> codecResult) {
    return SpotifyUserCapabilities.from(codecResult);
  }
}
