part of 'package:api_bloc/api_bloc.dart';

/// Ancestor class of every state used in [ApiBloc].
class BlocStates<T extends Object?> {
  /// [BlocStates] consist of [message] as a status on what's going on
  /// in this state and [data] that will be frequently used inside any state.
  const BlocStates({this.message = '', this.data});

  /// Status message indicating what's going on in this state.
  final String message;

  /// An optional object in state.
  final T? data;

  /// Encode [BlocStates] to json.
  Map<String, dynamic> get toJSON {
    return {
      'message': message,
      'data': data,
    };
  }

  /// Decode json to [BlocStates].
  static BlocStates fromJSON(Map<String, dynamic> json) {
    return BlocStates(
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() {
    return '$runtimeType${toJSON.entries.map((e) => '${e.key}: ${e.value}')}';
  }
}
