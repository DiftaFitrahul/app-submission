abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class ClientFailure extends Failure {
  ClientFailure({required super.message});
}
