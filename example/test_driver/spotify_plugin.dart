import 'dart:async';
import 'package:flutter_driver/driver_extension.dart';
//import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';
import 'package:spotify/spotify.dart';

SpotifyAppRemote appRemote;
SpotifySessionManager sessionManager;

void main() {
  final Completer<String> completer = Completer<String>();
  enableFlutterDriverExtension(handler: (_) => completer.future);

  setUpAll(() async {
    setup();

    const String tokenSwapUrlString = "http://localhost:1234/swap";
    const String tokenRefreshUrlString = "http://localhost:1234/refresh";

    const String clientId = "a099d4e024644ce8898e125862644b93";
    const String redirectUriString = "flutter-spotify-example://spotify-login"
        "-callback";

    SpotifyConfiguration configuration = SpotifyConfiguration(
      clientId: clientId,
      redirectUrl: Uri.dataFromString(redirectUriString),
    );

    configuration.playUri = "";
    configuration.tokenSwapUrl = Uri.dataFromString(tokenSwapUrlString);
    configuration.tokenRefreshUrl = Uri.dataFromString(tokenRefreshUrlString);

    sessionManager = await SpotifySessionManager
        .initialize(configuration);

    appRemote = await SpotifyAppRemote.initialize(
        configuration: configuration,
        logLevel: SpotifyAppRemoteLogLevel.debug
    );

    SpotifyScope scope = SpotifyScope.appRemoteControl;
    await sessionManager.initiateSessionWithScope(scope);
  });

  group(SpotifyContentAPI, contentApiTest);
  group(SpotifyImageAPI, imageApiTest);
  group(SpotifyPlayerAPI, playerApiTest);
  group(SpotifyUserAPI, userApiTest);
  group(SpotifyAppRemote, appRemoteTest);
  group(SpotifySessionManager, sessionManagerTest);

  tearDownAll(() {
    appRemote.disconnect();
    completer.complete(null);
  });
}

class TestingDelegate implements SpotifySessionManagerDelegate {
  @override
  void sessionManagerDidInitiateSession(SpotifySession session,
      [SpotifySessionManager sessionManager]) async {
    await appRemote.connect();
  }

  @override
  void sessionManagerShouldRequestAccessTokenWithAuthorizationCode(
      String authorizationCode, [SpotifySessionManager sessionManager]) {

  }

  @override
  void sessionManagerDidRenewSession(SpotifySession session,
      [SpotifySessionManager sessionManager]) {

  }

  @override
  void sessionManagerDidFailWithException(Exception e,
      [SpotifySessionManager sessionManager]) {

  }
}

void contentApiTest() {
  test('fetchRootContentItemsForType', () async {
    List<SpotifyContentItem> contentItems = await appRemote.contentAPI
        .fetchRootContentItemsForType(SpotifyContentType.default_);
    expect(contentItems, allOf(
        isList,
        isNotEmpty,
        everyElement(isNotNull)
    ));
  });

  test('fetchChildrenOfContentItem', () async {
    List<SpotifyContentItem> rootContentItems = await appRemote.contentAPI
        .fetchRootContentItemsForType(SpotifyContentType.default_);
    SpotifyContentItem rootContentItem = rootContentItems[0];

    List<SpotifyContentItem> contentItems = await appRemote.contentAPI
        .fetchChildrenOfContentItem(rootContentItem);
    expect(contentItems, allOf(
        isList,
        isNotEmpty,
        everyElement(isNotNull)
    ));
  });

  test('fetchRecommendedContentItemsForType', () async {
    List<SpotifyContentItem> contentItems = await appRemote.contentAPI
        .fetchRecommendedContentItemsForType(SpotifyContentType.default_);
    expect(contentItems, allOf(
        isList,
        isNotEmpty,
        everyElement(isNotNull)
    ));
  });
}

void imageApiTest() {
  test('fetchImageForItem', () async {
    // TODO
  }, skip: true);
}

void playerApiTest() {
  test('play', () async {
    // TODO
  }, skip: true);

  test('playItem', () async {
    // TODO
  }, skip: true);

  test('resume', () async {
    // TODO
  }, skip: true);

  test('pause', () async {
    // TODO
  }, skip: true);

  test('skipToNext', () async {
    // TODO
  }, skip: true);

  test('skipToPrevious', () async {
    // TODO
  }, skip: true);

  test('skipToPosition', () async {
    // TODO
  }, skip: true);

  test('seekForward15Seconds', () async {
    // TODO
  }, skip: true);

  test('seekBackward15Seconds', () async {
    // TODO
  }, skip: true);

  test('setShuffle', () async {
    // TODO
  }, skip: true);

  test('setRepeatMode', () async {
    // TODO
  }, skip: true);

  test('getPlayerState', () async {
    // TODO
  }, skip: true);

  test('subscribeToPlayerState', () async {
    // TODO
  }, skip: true);

  test('unsubscribeToPlayerState', () async {
    // TODO
  }, skip: true);

  test('enqueueTrackUri', () async {
    // TODO
  }, skip: true);

  test('getAvailablePodcastPlaybackSpeeds', () async {
    // TODO
  }, skip: true);

  test('getCurrentPodcastPlaybackSpeed', () async {
    // TODO
  }, skip: true);

  test('setPodcastPlaybackSpeed', () async {
    // TODO
  }, skip: true);

  test('getCrossfadeState', () async {
    // TODO
  }, skip: true);

  // TODO: Delegates
}

void userApiTest() {
  test('fetchCapabilities', () async {
    // TODO
  }, skip: true);

  test('subscribeToCapabilityChanges', () async {
    // TODO
  }, skip: true);

  test('unsubscribeToCapabilityChanges', () async {
    // TODO
  }, skip: true);

  test('fetchLibraryStateForUri', () async {
    // TODO
  }, skip: true);

  test('addUriToLibrary', () async {
    // TODO
  }, skip: true);

  test('removeUriFromLibrary', () async {
    // TODO
  }, skip: true);

  // TODO: Delegates
}

void appRemoteTest() {
  test('checkIfSpotifyAppIsActive', () async {
    // TODO
  }, skip: true);

  test('version', () async {
    // TODO
  }, skip: true);

  test('spotifyItunesItemIdentifier', () async {
    // TODO
  }, skip: true);

  test('connectionParameters', () async {
    // TODO
  }, skip: true);

  test('isConnected', () async {
    // TODO
  }, skip: true);

  test('connect', () async {
    // TODO
  }, skip: true);

  test('disconnect', () async {
    // TODO
  }, skip: true);

  test('authorizeAndPlayUri', () async {
    // TODO
  }, skip: true);

  test('authorizationParametersFromURL', () async {
    // TODO
  }, skip: true);

  // TODO: Delegates
}

void sessionManagerTest() {
  test('session', () async {
    // TODO
  }, skip: true);

  test('isSpotifyAppInstalled', () async {
    // TODO
  }, skip: true);

  test('initiateSessionWithScope', () async {
    // TODO
  }, skip: true);

  test('renewSession', () async {
    // TODO
  }, skip: true);

  // TODO: Delegates
}