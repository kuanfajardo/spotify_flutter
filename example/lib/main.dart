import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:spotify/spotify.dart';

import 'package:tabbed_scaffold/tabbed_scaffold.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _spotifyVersion = -2;
  SpotifyAppRemote _appRemote;
  SpotifySessionManager _sessionManager;
  SessionManagerBloc _sessionManagerDelegateBloc = SessionManagerBloc();
  AppRemoteBloc _appRemoteBloc = AppRemoteBloc();

  @override
  void initState() {
    super.initState();
//    initSpotify();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initSpotify() async {
    setup();

    // Setup Configuration
    final String clientId = "a099d4e024644ce8898e125862644b93";
    final String redirectUriString = "flutter-spotify-example://spotify-login"
        "-callback";
    final String tokenSwapUrlString = "http://localhost:1234/swap";
    final String tokenRefreshUrlString = "http://localhost:1234/refresh";

    SpotifyConfiguration configuration = SpotifyConfiguration(
      clientId: clientId,
      redirectUrl: Uri.dataFromString(redirectUriString),
      playUri: "",
      tokenSwapUrl: Uri.dataFromString(tokenSwapUrlString),
      tokenRefreshUrl: Uri.dataFromString(tokenRefreshUrlString),
    );

    // Setup Session Manager
    SpotifySessionManager sessionManager = await SpotifySessionManager
        .initialize(configuration);

    _sessionManagerDelegateBloc.onInit(sessionManager);

    // Setup App Remote
    SpotifyAppRemote appRemote = await SpotifyAppRemote.initialize(
      configuration,
      logLevel: SpotifyAppRemoteLogLevel.debug,
    );

    _appRemoteBloc.onInit(appRemote);

    // Set State
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appRemote = appRemote;
      _sessionManager = sessionManager;
    });

    // Initiate Session
    SpotifyScope scope = SpotifyScope.appRemoteControl;
    sessionManager.initiateSessionWithScope(scope);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: BlocBuilder(
          bloc: _sessionManagerDelegateBloc,
          builder: (context, SessionManagerState state) {
            return Center(
              child: Text(state.session != null
                  ? 'Running on: $_spotifyVersion\n'
                  : 'Not Initiated'
              ),
            );
          }
        )
      ),
    );
  }
}
