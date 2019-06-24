enum SpotifyExceptionCode { unknown, authorizationFailed, renewSessionFailed,
  jsonFailed, }

class SpotifyException implements Exception {
  final SpotifyExceptionCode errorCode;
  final String message;

  SpotifyException(this.errorCode, {this.message});

  @override
  String toString() {
    return 'SpotifyException (${this.errorCode}): ${this.message}';
  }
}

