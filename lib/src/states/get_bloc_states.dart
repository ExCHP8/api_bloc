part of 'package:api_bloc/api_bloc.dart';

/// On fetching request, there is usually consist of three states.
///
/// which is [loading] as initial state and on progress state,
/// [success] is state where we successfully fetch data from api,
/// [error] is the state where something unexpected happen, like
/// failed on fetching data, parsing data, and another unthinkable event.
enum GetStateType {
  /// Represents the loading state when data is being fetched.
  loading,

  /// Represents the success state when data fetching is successful.
  success,

  /// Represents the error state when an error occurs during data fetching.
  error
}

/// The base state class used in [GetController].
///
/// The [GetStates] class extends [BlocStates] to provide a generic state
/// that includes [GetStateType], [message], and a nullable [data] object.
class GetStates<T extends Object?> extends BlocStates<T> {
  /// Create a [GetStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [GetStateType] of the state.
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  const GetStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final GetStateType type;

  @override
  Map<String, dynamic> get asMap {
    return {...super.asMap, 'type': type};
  }
}

/// Represents the loading state when data is being fetched in [GetController].
class GetLoadingState<T extends Object?> extends GetStates<T> {
  /// Create a [GetLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// GetLoadingState<double>(data: 0.0));
  /// ```
  const GetLoadingState({super.message, super.data})
      : super(type: GetStateType.loading);
}

/// Represents the success state when data fetching is successful in
/// [GetController].
class GetSuccessState<T extends Object> extends GetStates<T> {
  /// Create a [GetSuccessState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// GetSuccessState<Model>(data: Model()));
  /// ```
  const GetSuccessState({super.message, required super.data})
      : assert(data != null, 'data is required in GetSuccessState'),
        super(type: GetStateType.success);
}

/// Represents the error state when an error occurs during data fetching in
/// [GetController].
class GetErrorState<T extends Object?> extends GetStates<T> {
  /// Create a [GetErrorState] with an optional [message] and [data].
  const GetErrorState({super.message, super.data})
      : super(type: GetStateType.error);
}
