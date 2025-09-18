
abstract class BaseState {
  final DateTime timestamp;
  final String? requestId;

  BaseState({DateTime? timestamp, this.requestId})
    : timestamp = timestamp ?? DateTime.now();
}


class LoadingState extends BaseState {
  final String? message;
  final double? progress;

  LoadingState({this.message, this.progress, super.timestamp, super.requestId});
}


class ErrorState extends BaseState {
  final String message;
  final String? errorCode;
  final bool isRetryable;
  final dynamic originalError;

  ErrorState(
    this.message, {
    this.errorCode,
    this.isRetryable = true,
    this.originalError,
    super.timestamp,
    super.requestId,
  });
}


class SuccessState<T> extends BaseState {
  final T data;
  final String? message;

  SuccessState(this.data, {this.message, super.timestamp, super.requestId});
}


class InitialState extends BaseState {
  InitialState({super.timestamp, super.requestId});
}


class EmptyState extends BaseState {
  final String? message;

  EmptyState({this.message, super.timestamp, super.requestId});
}
