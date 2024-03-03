part of 'package:api_bloc/api_bloc.dart';

/// On fetching request, there is usually consist of three states.
///
/// which is [loading] as initial state and on progress state,
/// [success] is state where we successfully fetch data from api,
/// [error] is the state where something unexpected happen, like
/// failed on fetching data, parsing data, and another unthinkable event.
enum ReadStateType {
  /// Represents the loading state when data is being fetched.
  loading,

  /// Represents the success state when data fetching is successful.
  success,

  /// Represents the error state when an error occurs during data fetching.
  error;

  /// Decode json to [ReadStateType].
  static ReadStateType fromJSON(Map<String, dynamic> json) {
    return ReadStateType.values[json['index']];
  }

  /// Encode [ReadStateType] to json.
  Map<String, dynamic> get toJSON {
    return {
      'name': name,
      'index': index,
    };
  }
}

/// The base state class used in [ReadController].
///
/// The [ReadStates] class extends [BlocStates] to provide a generic state
/// that includes [ReadStateType], [message], and a nullable [data] object.
class ReadStates<T extends Object?> extends BlocStates<T> {
  /// Create a [ReadStates] with the specified [type], [message], and [data].
  ///
  /// The [type] parameter represents the [ReadStateType] of the state.
  /// The [message] parameter represents an optional error message associated with the state.
  /// The [data] parameter represents an optional data object associated with the state.
  const ReadStates({required this.type, super.message, super.data});

  /// The type of the state, representing what type of state is this.
  final ReadStateType type;

  @override
  Map<String, dynamic> get toJSON {
    return {
      ...super.toJSON,
      'type': type.toJSON,
    };
  }

  static ReadStates<T> fromJSON<T extends Object>(Map<String, dynamic> json) {
    switch (ReadStateType.fromJSON(json['type'])) {
      case ReadStateType.loading:
        return ReadLoadingState<T>(
          data: json['data'],
          message: json['message'],
        );
      case ReadStateType.success:
        return ReadSuccessState<T>(
          data: json['data'],
          message: json['message'],
        );
      case ReadStateType.error:
        return ReadErrorState<T>(
          data: json['data'],
          message: json['message'],
        );
    }
  }
}

/// Represents the loading state when data is being fetched in [ReadController].
class ReadLoadingState<T extends Object?> extends ReadStates<T> {
  /// Create a [ReadLoadingState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// ReadLoadingState<double>(data: 0.0));
  /// ```
  const ReadLoadingState({super.message, super.data})
      : super(type: ReadStateType.loading);
}

/// Represents the success state when data fetching is successful in
/// [ReadController].
class ReadSuccessState<T extends Object> extends ReadStates<T> {
  /// Create a [ReadSuccessState] with an optional [message] and [data].
  ///
  /// Don't forget to define the object type to emphasize the data that we're
  /// going to use in [ApiBloc].
  /// ```dart
  /// ReadSuccessState<Model>(data: Model()));
  /// ```
  const ReadSuccessState({super.message, required T data})
      : super(data: data, type: ReadStateType.success);
}

/// Represents the error state when an error occurs during data fetching in
/// [ReadController].
class ReadErrorState<T extends Object?> extends ReadStates<T> {
  /// Create a [ReadErrorState] with an optional [message] and [data].
  const ReadErrorState({super.message, super.data})
      : super(type: ReadStateType.error);
}
