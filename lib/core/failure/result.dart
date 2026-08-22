sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  Success({required this.data});
}

class Failure<T> extends Result<T> {
  final String message;
  final Object? error;

  Failure(this.message, [this.error]);
}
