class ServerExceptions implements Exception {
  final String? message;
  const ServerExceptions({this.message});
}

class DataExceptions implements Exception {
  final String? message;
  const DataExceptions({this.message});
}

class ClientExceptions implements Exception {
  final String? message;
  const ClientExceptions({this.message});
}
