part of 'package:api_bloc/api_bloc.dart';

/// The different types of states that can be represented in [WriteController].
enum WriteStateType {
  /// Represents the idle state when there is no request is in progress.
  idle,

  /// Represents the loading state when a request is in progress.
  loading,

  /// Represents the success state when a request is successfully submitted.
  success,

  /// Represents the failed state when a request submission fails.
  failed,

  /// Represents the error state when an error occurs during request submission.
  error;

  /// Decode json to [WriteStateType].
  static WriteStateType fromJSON(Map<String, dynamic> json) {
    return WriteStateType.values[json['index']];
  }

  /// Encode [WriteStateType] to json.
  Map<String, dynamic> get toJSON {
    return {
      'name': name,
      'index': index,
    };
  }
}

/// The base state class used in [WriteController].
///
/// The [WriteStates] class extends [BlocStates] to provide a generic state
/// that includes [WriteStateType], [message], and a nullable [data] object.
class WriteStates<T extends Object?> extends BlocStates<T> {
  /// Create a [WriteStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [WriteStateType] of the state.
  /// The [message] parameter represents an optional error message associated
  /// with the state.
  /// The [data] parameter represents an optional data object associated with
  /// the state.
  const WriteStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final WriteStateType type;

  @override
  Map<String, dynamic> get toJSON {
    return {
      ...super.toJSON,
      'type': type.toJSON,
    };
  }

  static WriteStates<T> fromJSON<T extends Object>(Map<String, dynamic> json) {
    switch (WriteStateType.fromJSON(json['type'])) {
      case WriteStateType.loading:
        return WriteLoadingState<T>(
            message: json['message'], data: json['data']);
      case WriteStateType.success:
        return WriteSuccessState<T>(
          message: json['message'],
          data: json['data'],
        );
      case WriteStateType.failed:
        return WriteFailedState<T>(
          message: json['message'],
          data: json['data'],
        );
      case WriteStateType.error:
        return WriteErrorState<T>(
          message: json['message'],
          data: json['data'],
        );
      case WriteStateType.idle:
        return WriteIdleState<T>(
          message: json['message'],
          data: json['data'],
        );
    }
  }
}

/// Represents the idle state when no request is in progress in [WriteController].
class WriteIdleState<T extends Object?> extends WriteStates<T> {
  /// Create a [WriteIdleState] with an optional [message] and [data].
  const WriteIdleState({super.message, super.data})
      : super(type: WriteStateType.idle);
}

/// Represents the loading state when a request is in progress in [WriteController].
class WriteLoadingState<T extends Object?> extends WriteStates<T> {
  /// Create a [WriteLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// WriteLoadingState<double>(data: 0.0));
  /// ```
  const WriteLoadingState({super.message, super.data})
      : super(type: WriteStateType.loading);
}

/// Represents the success state when a request is successfully submitted in
/// [WriteController].
class WriteSuccessState<T extends Object> extends WriteStates<T> {
  /// Create a [WriteSuccessState] with a required [data] object and an optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// WriteSuccessState<Model>(data: Model()));
  /// ```
  const WriteSuccessState({super.message, required T data})
      : super(data: data, type: WriteStateType.success);
}

/// Represents the failed state when a request submission fails in
/// [WriteController].
class WriteFailedState<T extends Object> extends WriteStates<T> {
  /// Create a [WriteFailedState] with a required [data] object and an
  /// optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// WriteFailedState<Model>(data: Model()));
  /// ```
  const WriteFailedState({super.message, required T data})
      : super(data: data, type: WriteStateType.failed);
}

/// Represents the error state when an error occurs during request submission in
/// [WriteController].
class WriteErrorState<T extends Object?> extends WriteStates<T> {
  /// Represents the error state when an error occurs during request submission in
  /// [WriteController].
  const WriteErrorState({super.message, super.data})
      : super(type: WriteStateType.error);
}
