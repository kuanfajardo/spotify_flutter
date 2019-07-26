import 'package:spotify/encoding/encoding.dart';

import 'package:spotify/api/lib/user/methods.dart' as UserMethods;
import 'package:spotify/api/lib/user/keys.dart' as UserKeys;

// Caller
class SpotifyUserAPI {
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
    return invokeMethod<bool>(UserMethods.removeUriFromLibrary, uri.toString());
  }
}

class SpotifyLibraryState implements FlutterChannelCodable {
  final Uri uri;
  final bool isAdded;
  final bool canAdd;

  SpotifyLibraryState._from(Map<String, dynamic> channelObject) :
        uri = Uri.dataFromString(channelObject[UserKeys.uri]),
        isAdded = channelObject[UserKeys.isAdded],
        canAdd = channelObject[UserKeys.canAdd];

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.uri: this.uri,
      UserKeys.isAdded: this.isAdded,
      UserKeys.canAdd: this.canAdd,
    };
  }

  static SpotifyLibraryState from(Map<String, dynamic> channelObject) {
    return SpotifyLibraryState._from(channelObject);
  }
}

class SpotifyUserCapabilities implements FlutterChannelCodable {
  final bool canPlayOnDemand;

  SpotifyUserCapabilities._from(Map<String, dynamic> channelObject) :
      canPlayOnDemand = channelObject[UserKeys.canPlayOnDemand];

  @override
  Map<String, dynamic> encode() {
    return {
      UserKeys.canPlayOnDemand: this.canPlayOnDemand,
    };
  }

  static SpotifyUserCapabilities from(Map<String, dynamic> channelObject) {
    return SpotifyUserCapabilities.from(channelObject);
  }
}
