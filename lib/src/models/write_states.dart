part of 'package:api_bloc/api_bloc.dart';

/// The base state class used in [WriteController].
///
/// The [WriteStates] class extends [BlocStates] to provide a generic state
/// that includes [message], and a dynamic [data] object. This limited to five states in total.
/// These states are [WriteIdleState], [WriteLoadingState], [WriteSuccessState], [WriteFailedState], and [WriteErrorState].
sealed class WriteStates<T extends dynamic> extends BlocStates<T> {
  /// Create a [WriteStates] with the specified [message], and [data].
  ///
  /// The [message] parameter represents an optional error message associated
  /// with the state.
  /// The [data] parameter represents an optional data object associated with
  /// the state.
  const WriteStates({super.message, T? data}) : super(data: data as T);

  /// Creates a [WriteIdleState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [WriteIdleState] during the idle state
  /// of a [WriteController].
  ///
  /// ```dart
  /// emit(WriteStates.idle(
  ///   message: 'idle',
  ///   data: null,
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(WriteIdleState(
  ///   message: 'idle',
  ///   data: null,
  /// ));
  /// ```
  static WriteIdleState<T> idle<T extends dynamic>({
    String message = '',
    T? data,
  }) {
    return WriteIdleState<T>(
      message: message,
      data: data,
    );
  }

  /// Creates a [WriteLoadingState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [WriteLoadingState] during the loading state
  /// of a [WriteController].
  ///
  /// ```dart
  /// emit(WriteStates.loading<double>(
  ///   message: 'loading',
  ///   data: 0.5,
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(WriteLoadingState<double>(
  ///   message: 'loading',
  ///   data: 0.5,
  /// ));
  /// ```

  static WriteLoadingState<T> loading<T extends dynamic>({
    String message = '',
    T? data,
  }) {
    return WriteLoadingState<T>(data: data);
  }

  /// Creates a [WriteSuccessState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [WriteSuccessState] during the success state
  /// of a [WriteController].
  ///
  /// ```dart
  /// emit(WriteStates.success<DataModel>(
  ///   message: 'success',
  ///   data: DataModel(...),
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(WriteSuccessState<DataModel>(
  ///   message: 'success',
  ///   data: DataModel(...),
  /// ));
  /// ```
  static WriteSuccessState<T> success<T extends Object>({
    String message = '',
    required T data,
  }) {
    return WriteSuccessState<T>(
      message: message,
      data: data,
    );
  }

  /// Creates a [WriteFailedState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [WriteFailedState] during the failed state
  /// of a [WriteController].
  ///
  /// ```dart
  /// emit(WriteStates.failed<ErrorModel>(
  ///   message: 'failed',
  ///   data: ErrorModel(...)
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(WriteFailedState<ErrorModel>(
  ///   message: 'failed',
  ///   data: ErrorModel(...),
  /// ));
  /// ```
  static WriteFailedState<T> failed<T extends Object>({
    String message = '',
    required T data,
  }) {
    return WriteFailedState<T>(
      message: message,
      data: data,
    );
  }

  /// Creates a [WriteErrorState] with the specified [message] and [data].
  ///
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  /// This method is used to create a [WriteErrorState] during the error state
  /// of a [WriteController].
  ///
  /// ```dart
  /// emit(WriteStates.error(
  ///   message: 'error',
  ///   data: null,
  /// ));
  ///
  /// // equals to this one
  ///
  /// emit(WriteErrorState(
  ///   message: 'error',
  ///   data: null,
  /// ));
  /// ```
  static WriteErrorState<T> error<T extends dynamic>({
    String message = '',
    T? data,
  }) {
    return WriteErrorState<T>(
      message: message,
      data: data,
    );
  }
}

/// Represents the idle state when no request is in progress in [WriteController].
final class WriteIdleState<T extends dynamic> extends WriteStates<T> {
  /// Create a [WriteIdleState] with an optional [message] and [data].
  const WriteIdleState({super.message, super.data});
}

/// Represents the loading state when a request is in progress in [WriteController].
final class WriteLoadingState<T extends dynamic> extends WriteStates<T> {
  /// Create a [WriteLoadingState] with an optional [message] and [data].
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  ///
  /// ```dart
  /// WriteLoadingState<double>(data: 0.0));
  /// ```
  const WriteLoadingState({super.message, super.data});
}

/// Represents the success state when a request is successfully submitted in
/// [WriteController].
final class WriteSuccessState<T extends Object> extends WriteStates<T> {
  /// Create a [WriteSuccessState] with a required [data] object and an optional [message].
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  ///
  /// ```dart
  /// WriteSuccessState<Model>(data: Model()));
  /// ```
  const WriteSuccessState({super.message, required super.data});
}

/// Represents the failed state when a request submission fails in
/// [WriteController].
final class WriteFailedState<T extends Object> extends WriteStates<T> {
  /// Create a [WriteFailedState] with a required [data] object and an
  /// optional [message].
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  ///
  /// ```dart
  /// WriteFailedState<Model>(data: Model()));
  /// ```
  const WriteFailedState({super.message, required super.data});
}

/// Represents the error state when an error occurs during request submission in
/// [WriteController].
final class WriteErrorState<T extends dynamic> extends WriteStates<T> {
  /// Represents the error state when an error occurs during request submission in
  /// [WriteController].
  const WriteErrorState({super.message, super.data});
}
