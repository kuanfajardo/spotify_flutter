import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:spotify/spotify.dart';

void main() => runApp(MyApp());

const String tokenSwapUrlString = "http://localhost:1234/swap";
const String tokenRefreshUrlString = "http://localhost:1234/refresh";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _spotifyVersion = 'Unknown';
  SpotifyAppRemote _appRemote;
  SpotifySessionManager _sessionManager;

  @override
  void initState() {
    super.initState();
    initSpotify();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initSpotify() async {
    setup();

    final String clientId = "a099d4e024644ce8898e125862644b93";
    final String redirectUriString = "flutter-spotify-example://spotify-login"
        "-callback";

    SpotifyConfiguration configuration = SpotifyConfiguration(
      clientId: clientId,
      redirectUrl: Uri.dataFromString(redirectUriString),
    );

    configuration.playUri = "";
    configuration.tokenSwapUrl = Uri.dataFromString(tokenSwapUrlString);
    configuration.tokenRefreshUrl = Uri.dataFromString(tokenRefreshUrlString);

    SpotifySessionManager sessionManager = SpotifySessionManager(configuration);

    SpotifyAppRemote appRemote = SpotifyAppRemote(
        configuration: configuration,
        logLevel: SpotifyAppRemoteLogLevel.debug
    );

    SpotifyScope scope = SpotifyScope.appRemoteControl;
    sessionManager.initiateSessionWithScope(scope);

    String spotifyVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      spotifyVersion = await SpotifyAppRemote.version();
    } on PlatformException {
      spotifyVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _spotifyVersion = spotifyVersion;
      _appRemote = appRemote;
      _sessionManager = sessionManager;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_spotifyVersion\n'),
        ),
      ),
    );
  }
}
