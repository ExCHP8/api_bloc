part of 'package:api_bloc/api_bloc.dart';

/// All states that can be represented in [BlocController].
///
/// [message] is a status on what's going on in this state and
/// [data] is an optional object in state.
///
/// ```dart
/// final state = BlocStates(
///   message: 'success',
///   data: {'key': 'value'}
/// );
///
/// emit(state);
/// ```
class BlocStates<T extends dynamic> extends Equatable {
  /// Create a [BlocStates] with the specified [message] and [data].
  ///
  /// The [message] parameter represents the status message indicating
  /// what's going on in this state.
  /// The [data] parameter represents an optional object in state.
  ///
  /// ```dart
  /// final state = BlocStates(
  ///   message: 'success',
  ///   data: {'key': 'value'}
  /// );
  ///
  /// emit(state);
  /// ```
  const BlocStates({this.message = 'No Information Provided', T? data})
      : data = data as T;

  /// The status message indicating what's going on in this state.
  final String message;

  /// An dynamic object in state.
  final T data;

  /// Encode [BlocStates] to JSON.
  ///
  /// ```dart
  /// final state = BlocStates(
  ///   message: 'success',
  ///   data: {'key': 'value'}
  /// );
  ///
  /// print(state.toJSON); // BlocStates(message: success, data: {key: value}}
  /// ```
  Map<String, dynamic> get toJSON {
    return {
      'message': message,
      'data': data,
      'type': runtimeType.toString(),
    };
  }

  /// Decode JSON to [BlocStates]. with [BlocStates.message] by default empty string, and [BlocStates.data] as null.
  ///
  /// ```dart
  /// final json = {
  ///   'message': 'success',
  ///   'data': {'key': 'value'}
  /// };
  ///
  /// final state = BlocStates.fromJSON(json);
  /// ```
  static BlocStates<T> fromJSON<T extends dynamic>(Map<String, dynamic> value) {
    return BlocStates<T>(
      data: value['data'],
      message: value['message'] ?? 'No Information Provided',
    );
  }

  @override
  String toString() {
    return '$runtimeType${toJSON.entries.map((e) => '${e.key}: ${e.value}')}';
  }

  @override
  List<Object?> get props => [for (var item in toJSON.values) item];
}
