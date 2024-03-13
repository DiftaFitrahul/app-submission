class ServerExceptions implements Exception {
  final String? message;
  const ServerExceptions({this.message});
}

class DataExceptions implements Exception {
  final String? message;
  const DataExceptions({this.message});
}
