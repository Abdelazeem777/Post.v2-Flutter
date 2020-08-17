class RequestException implements Exception {
  String _message;

  RequestException(this._message);

  @override
  String toString() {
    return _message;
  }
}
