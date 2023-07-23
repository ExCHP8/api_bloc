part of 'package:api_bloc/api_bloc.dart';

/// The different types of states that can be represented in [SubmitController].
enum SubmitStateType {
  /// Represents the idle state when there is no request is in progress.
  idle,

  /// Represents the loading state when a request is in progress.
  loading,

  /// Represents the success state when a request is successfully submitted.
  success,

  /// Represents the failed state when a request submission fails.
  failed,

  /// Represents the error state when an error occurs during request submission.
  error
}

/// The base state class used in [SubmitController].
///
/// The [SubmitStates] class extends [BlocStates] to provide a generic state
/// that includes [SubmitStateType], [message], and a nullable [data] object.
class SubmitStates<T extends Object?> extends BlocStates<T> {
  /// Create a [SubmitStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [SubmitStateType] of the state.
  /// The [message] parameter represents an optional error message associated
  /// with the state.
  /// The [data] parameter represents an optional data object associated with
  /// the state.
  const SubmitStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final SubmitStateType type;

  @override
  Map<String, dynamic> get asMap {
    return {...super.asMap, 'type': type};
  }
}

/// Represents the idle state when no request is in progress in [SubmitController].
class SubmitIdleState<T extends Object?> extends SubmitStates<T> {
  /// Create a [SubmitIdleState] with an optional [message] and [data].
  const SubmitIdleState({super.message, super.data})
      : super(type: SubmitStateType.idle);
}

/// Represents the loading state when a request is in progress in [SubmitController].
class SubmitLoadingState<T extends Object?> extends SubmitStates<T> {
  /// Create a [SubmitLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SubmitLoadingState<double>(data: 0.0));
  /// ```
  const SubmitLoadingState({super.message, super.data})
      : super(type: SubmitStateType.loading);
}

/// Represents the success state when a request is successfully submitted in
/// [SubmitController].
class SubmitSuccessState<T extends Object> extends SubmitStates<T> {
  /// Create a [SubmitSuccessState] with a required [data] object and an optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SubmitSuccessState<Model>(data: Model()));
  /// ```
  const SubmitSuccessState({super.message, required super.data})
      : super(type: SubmitStateType.success);
}

/// Represents the failed state when a request submission fails in
/// [SubmitController].
class SubmitFailedState<T extends Object> extends SubmitStates<T> {
  /// Create a [SubmitFailedState] with a required [data] object and an
  /// optional [message].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// SubmitFailedState<Model>(data: Model()));
  /// ```
  const SubmitFailedState({super.message, required super.data})
      : super(type: SubmitStateType.failed);
}

/// Represents the error state when an error occurs during request submission in
/// [SubmitController].
class SubmitErrorState<T extends Object?> extends SubmitStates<T> {
  /// Represents the error state when an error occurs during request submission in
  /// [SubmitController].
  const SubmitErrorState({super.message, super.data})
      : super(type: SubmitStateType.error);
}
