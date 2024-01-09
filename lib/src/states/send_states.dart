part of 'package:api_bloc/api_bloc.dart';

/// The different types of states that can be represented in [SendController].
enum SendStateType {
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

  /// Decode json to [SendStateType].
  static SendStateType fromJSON(Map<String, dynamic> json) {
    return SendStateType.values[json['index']];
  }

  /// Encode [SendStateType] to json.
  Map<String, dynamic> get toJSON {
    return {
      'name': name,
      'index': index,
    };
  }
}

/// The base state class used in [SendController].
///
/// The [SendStates] class extends [BlocStates] to provide a generic state
/// that includes [SendStateType], [message], and a nullable [data] object.
class SendStates<T extends Object?> extends BlocStates<T> {
  /// Create a [SendStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [SendStateType] of the state.
  /// The [message] parameter represents an optional error message associated
  /// with the state.
  /// The [data] parameter represents an optional data object associated with
  /// the state.
  const SendStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final SendStateType type;

  @override
  Map<String, dynamic> get toJSON {
    return {
      ...super.toJSON,
      'type': type.toJSON,
    };
  }

  static SendStates fromJSON(Map<String, dynamic> json) {
    return SendStates(
      type: SendStateType.fromJSON(json['type']),
      data: json['data'],
      message: json['message'],
    );
  }
}

/// Represents the idle state when no request is in progress in [SendController].
class SendIdleState<T extends Object?> extends SendStates<T> {
  /// Create a [SendIdleState] with an optional [message] and [data].
  const SendIdleState({super.message, super.data})
      : super(type: SendStateType.idle);
}

/// Represents the loading state when a request is in progress in [SendController].
class SendLoadingState<T extends Object?> extends SendStates<T> {
  /// Create a [SendLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SendLoadingState<double>(data: 0.0));
  /// ```
  const SendLoadingState({super.message, super.data})
      : super(type: SendStateType.loading);
}

/// Represents the success state when a request is successfully submitted in
/// [SendController].
class SendSuccessState<T extends Object> extends SendStates<T> {
  /// Create a [SendSuccessState] with a required [data] object and an optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SendSuccessState<Model>(data: Model()));
  /// ```
  const SendSuccessState({super.message, required super.data})
      : assert(data != null, 'data is required in SendSuccessState'),
        super(type: SendStateType.success);
}

/// Represents the failed state when a request submission fails in
/// [SendController].
class SendFailedState<T extends Object> extends SendStates<T> {
  /// Create a [SendFailedState] with a required [data] object and an
  /// optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SendFailedState<Model>(data: Model()));
  /// ```
  const SendFailedState({super.message, required super.data})
      : assert(data != null, 'data is required in SendFailedState'),
        super(type: SendStateType.failed);
}

/// Represents the error state when an error occurs during request submission in
/// [SendController].
class SendErrorState<T extends Object?> extends SendStates<T> {
  /// Represents the error state when an error occurs during request submission in
  /// [SendController].
  const SendErrorState({super.message, super.data})
      : super(type: SendStateType.error);
}
