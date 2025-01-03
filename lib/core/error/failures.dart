import 'package:weather_app/core/constants/messages.dart';

enum FailureType { serverError, connectionError, cacheError }

class Failure {
  final FailureType type;
  final String message;

  const Failure(this.type, this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;

  static const Map<FailureType, String> _defaultMessages = {
    FailureType.serverError: SERVER_FAILURE_MESSAGE,
    FailureType.connectionError: CONNECTION_FAILURE_MESSAGE,
    FailureType.cacheError: CACHE_FAILURE_MESSAGE,
  };

  factory Failure.fromType(FailureType type, {String? customMessage}) {
    return Failure(type, customMessage ?? _defaultMessages[type]!);
  }
}
