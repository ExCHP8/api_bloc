part of 'package:api_bloc/api_bloc.dart';

/// On fetching request, there is usually consist of three states.
///
/// which is [loading] as initial state and on progress state,
/// [success] is state where we successfully fetch data from api,
/// [error] is the state where something unexpected happen, like
/// failed on fetching data, parsing data, and another unthinkable event.
enum FetchStateType {
  /// Represents the loading state when data is being fetched.
  loading,

  /// Represents the success state when data fetching is successful.
  success,

  /// Represents the error state when an error occurs during data fetching.
  error
}

/// The base state class used in [FetchController].
///
/// The [FetchStates] class extends [BlocStates] to provide a generic state
/// that includes [FetchStateType], [message], and a nullable [data] object.
class FetchStates<T extends Object?> extends BlocStates<T> {
  /// Create a [FetchStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [FetchStateType] of the state.
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  const FetchStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final FetchStateType type;

  @override
  Map<String, dynamic> get asMap {
    return {...super.asMap, 'type': type};
  }
}

/// Represents the loading state when data is being fetched in [FetchController].
class FetchLoadingState<T extends Object?> extends FetchStates<T> {
  /// Create a [FetchLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// FetchLoadingState<double>(data: 0.0));
  /// ```
  const FetchLoadingState({super.message, super.data})
      : super(type: FetchStateType.loading);
}

/// Represents the success state when data fetching is successful in
/// [FetchController].
class FetchSuccessState<T extends Object> extends FetchStates<T> {
  /// Create a [FetchSuccessState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// FetchSuccessState<Model>(data: Model()));
  /// ```
  const FetchSuccessState({super.message, required super.data})
      : assert(data != null, 'data is required in FetchSuccessState'),
        super(type: FetchStateType.success);
}

/// Represents the error state when an error occurs during data fetching in
/// [FetchController].
class FetchErrorState<T extends Object?> extends FetchStates<T> {
  /// Create a [FetchErrorState] with an optional [message] and [data].
  const FetchErrorState({super.message, super.data})
      : super(type: FetchStateType.error);
}
